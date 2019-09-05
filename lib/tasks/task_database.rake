namespace :task_database do

  require 'nokogiri'
  require 'open-uri'
  require 'socksify'

  task :test => :environment do
    Socksify::proxy("127.0.0.1", 9050) {
      url = 'https://www.tiktok.com/tag/%E3%82%A2%E3%83%8B%E3%83%A1?langCountry=ja'
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read
      end
      doc = Nokogiri::HTML.parse(html, nil, charset)

      js = doc.search('script').to_s
      @tag_official_id = js.split('challengeId":')[1].split(',')[0].delete('"') unless js.split('challengeId":')[1].nil?
      @tag_title = js.split('challengeName":')[1].split(',')[0].delete('"') unless js.split('challengeName":')[1].nil?
      @tag_text = js.split('","text":"')[1].split(',')[0].delete('"') unless js.split('","text":"')[1].nil?
      @tag_cover_image = js.split('covers":')[1].split(',')[0].delete('["').delete('"]') unless js.split('covers":')[1].nil?
      @tag_posts_count = js.split('posts":')[2].split(',')[0] unless js.split('posts":')[2].nil?
      @tag_views_count = js.split('views":')[2].split(',')[0].delete('"').delete('}') unless js.split('views":')[2].nil?
      @tag_url = url

      tag = {
          "tag_official_id": @tag_official_id,
          "tag_title": @tag_title,
          "tag_text": @tag_text,
          "tag_cover_image": @tag_cover_image,
          "tag_posts_count": @tag_posts_count,
          "tag_views_count": @tag_views_count,
          "tag_url": @tag_url
      }

    puts tag
    }
  end

  task :get_tag_data => :environment do
    Parallel.each(Tag.all, in_processes: 10) do |tag|
      Tag.new_tag(tag.tag_title)
    end
  end

  task :get_video_from_tag => :environment do
    Tag.all.each do |tag|
      # sleep(10)
      begin
        Socksify::proxy("127.0.0.1", 9050) {
          url = URI.encode "https://www.tiktok.com/tag/#{tag.tag_title}"
          charset = nil
          html = open(url) do |f|
            charset = f.charset
            f.read
          end
          doc = Nokogiri::HTML.parse(html, nil, charset)
          embeds = []
          script = doc.css('script').to_s
          script.split('"embedUrl":"').drop(1).each do |n|
            embeds.push(n.split('","')[0])
          end

          Parallel.each(embeds, in_processes: 10) do |url|
            Tag.get_video_from_embed_new(url)
          end

        }
      rescue => error
        puts error
      end
    end
  end

  task :get_trending => :environment do
    begin
      Socksify::proxy("127.0.0.1", 9050) {
        url = URI.encode "https://www.tiktok.com/trending"
        charset = nil
        html = open(url) do |f|
          charset = f.charset
          f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)

        embeds = []
        script = doc.css('script').to_s
        script.split('"embedUrl":"').drop(1).each do |n|
          embeds.push(n.split('","')[0])
        end

        # if Video.where(video_trending: true).present?
        #   Video.where(video_trending: true).each do |v|
        #     v.video_trending = false
        #     v.save!
        #   end
        # end
        #
        # if Tag.where(tag_trending: true).present?
        #   Tag.where(tag_trending: true).each do |v|
        #     v.tag_trending = false
        #     v.save!
        #   end
        # end

        Parallel.each(embeds, in_processes: 10) do |url|
          Tag.get_video_from_embed_task_new(url)
        end
      }
    rescue => error
      puts "TASK_DATABASE 例外やで"
    end
  end

  def self.has_mb?(str)
    str.bytes do |b|
      return true if  (b & 0b10000000) != 0
    end
    false
  end

  task :upload_youtube => :environment do
    Gc.download_and_upload
  end

end


require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'google/apis/youtube_v3'

class Gc
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'idolsongplaylist'
  CLIENT_SECRETS_PATH = "#{Dir.pwd}/lib/tasks/t/client_secret.json"
  CREDENTIALS_PATH = File.join(Dir.home, '.credentials', "tokens.yaml")

  SCOPE = [ "https://www.googleapis.com/auth/youtube", "https://www.googleapis.com/auth/youtube.upload"]

  def self.authorize
    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'user123'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts 'Open the following URL in the browser and enter the ' +
               'resulting code after authorization'
      puts url
      code = STDIN.gets
      credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
  end

  def self.main(tag)
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.client_options.application_name = APPLICATION_NAME
    youtube.authorization = authorize
    path = "/var/www/sample-test/current/lib/tasks/m/output.mp4"
    snippet = { snippet: { title: "【TikTok】今週の「##{tag}」動画！【オモシロ人気動画】まとめ【2019年9月】", description: "TikTok Proが運営するTikTok分析から発見された本当に面白い今週のトレンド動画です。\nhttps://tiktok-pro.com\n#TikTok面白動画\n#TikTokオモシロ\n#トレンド" } }
    response = youtube.insert_video('snippet', snippet, upload_source: path, content_type: 'video/*')
    pp response
  end

  def self.download_and_upload
    require 'open-uri'

    @videos = []
    Tag.all.each do |tag|
      Video.all.each do |v|
        if v.video_tags.try(:include?, tag.tag_title)
          @videos.push(v)
        end
      end
      unless @videos.nil?
        @videos.each do | video |
          open(video.video_url) do |file|
            open("./lib/tasks/v/#{video.id.to_s}.mp4", "w+b") do |out|
              out.write(file.read)
              system("ffmpeg -i ./lib/tasks/v/#{video.id.to_s}.mp4 -r 30 -c:v h264 -c:a libfdk_aac ./lib/tasks/m/#{video.id.to_s}.mp4")
              system("echo file '#{video.id.to_s}.mp4' >> ./lib/tasks/m/videos.txt")
            end
          end
        end

        @videos = []
        system("ffmpeg -f concat -safe 0 -i ./lib/tasks/m/videos.txt -y ./lib/tasks/m/output.mp4")
        Gc.authorize
        Gc.main(tag.tag_title)
        system("rm -rf ./lib/tasks/v/")
        system("mkdir ./lib/tasks/v/")
        system("rm -rf ./lib/tasks/m/")
        system("mkdir ./lib/tasks/m/")
      end
    end

    # Video.where(video_trending: true).each do | video |
    #   open(video.video_url) do |file|
    #     open("./lib/tasks/v/#{video.id.to_s}.mp4", "w+b") do |out|
    #       out.write(file.read)
    #       system("ffmpeg -i #{Dir.pwd}/lib/tasks/v/#{video.id.to_s}.mp4 -r 30 -c:v h264 -c:a aac #{Dir.pwd}/lib/tasks/m/#{video.id.to_s}.mp4")
    #       system("echo file '#{Dir.pwd}/lib/tasks/m/#{video.id.to_s}.mp4' >> #{Dir.pwd}/lib/tasks/m/videos.txt")
    #     end
    #   end
    # end


  end

end
