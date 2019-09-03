namespace :task_database do

  require 'nokogiri'
  require 'open-uri'
  require 'selenium-webdriver'
  require 'tor-privoxy'
  require 'socksify/http'

  task :get_tag_data => :environment do
    Tag.all.each do |tag|
      Tag.new_tag(tag.tag_title)
    end
  end

  task :get_video_from_tag => :environment do

    Tag.all.each do |tag|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 120 # seconds
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      # options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")

      ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

      caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
      driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps
      driver.get "https://www.tiktok.com/tag/#{tag.tag_title}"

      doc = Nokogiri::HTML(driver.page_source)
      # elements = doc.search('script').to_s.split('name":"').drop(1)

      urls = []
      # elements.each do |el|
      #   unless el.split('"url":"')[1].nil?
      #     @video_url = el.split('"url":"')[1].split('","')[0]
      #     @video_official_id = @video_url.split('/').last
      #     urls.push("https://www.tiktok.com/embed/#{@video_official_id}")
      #   end
      # end

      doc.css('._video_feed_item').each do |item|
        puts item.css('a')[0][:href].split('/').last
        urls.push("https://www.tiktok.com/embed/#{item.css('a')[0][:href].split('/').last}")
      end

      urls.uniq.each do |u|
        Tag.get_video_from_embed(u, driver)
      end

      driver.close
      driver.quit
    end
  end

  task :get_trending => :environment do
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    # options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")

    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
    driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps
    driver.get "https://www.tiktok.com/ja/trending"

    doc = Nokogiri::HTML(driver.page_source)
    # elements = doc.search('script').to_s.split('name":"').drop(1)

    @video_trending = Video.where(video_trending: true)
    unless @video_trending.nil?
      @video_trending.each do |v|
        v.video_trending = false
        v.save
      end
    end

    @tag_trending = Tag.where(tag_trending: true)
    unless @tag_trending.nil?
      @tag_trending.each do |t|
        t.tag_trending = false
        t.save
      end
    end

    urls = []
    # elements.each do |el|
    #   unless el.split('"url":"')[1].nil?
    #     @video_url = el.split('"url":"')[1].split('","')[0]
    #     @video_official_id = @video_url.split('/').last
    #     urls.push("https://www.tiktok.com/embed/#{@video_official_id}")
    #   end
    # end

    doc.css('._video_feed_item').each do |item|
      puts item.css('a')[0][:href].split('/').last
      urls.push("https://www.tiktok.com/embed/#{item.css('a')[0][:href].split('/').last}")
    end

    urls.uniq.each do |u|
      Tag.get_video_from_embed_task(u, driver)
    end

    driver.close
    driver.quit
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
