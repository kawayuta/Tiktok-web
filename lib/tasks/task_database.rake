namespace :task_database do

  require 'nokogiri'
  require 'open-uri'
  require 'socksify'
  require 'selenium-webdriver'

  task :get_tag_data => :environment do
    Tag.all.find_in_batches(batch_size: 10) do |tags|
      tags.reverse.each do |tag|
        TagUpdateWorker.perform_async(tag.tag_title)
      end
    end
  end
  task :get_user_data => :environment do
    User.all.find_in_batches(batch_size: 10) do |users|
      users.reverse.each do |user|
        UserUpdateWorker.perform_async(user.user_official_id)
      end
    end
  end
  task :get_video_data => :environment do
    Video.all.find_in_batches(batch_size: 10) do |videos|
      videos.reverse.each do |video|
        VideoUpdateWorker.perform_async(video.video_official_id, nil)
      end
    end
  end

  task :get_video_from_tag => :environment do
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-setuid-sandbox')
    options.add_argument('--no-first-run')
    options.add_argument('--no-zygote')
    options.add_argument('--single-process')
    options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")
    driver = Selenium::WebDriver.for :chrome, options: options, http_client: client
    Tag.all.find_in_batches(batch_size: 10) do |tags|
      tags.reverse.each do |tag|
        begin
          driver.get "https://www.tiktok.com/tag/#{tag.tag_title}"
          doc = Nokogiri::HTML(driver.page_source)
          urls = []
          doc.css('._video_feed_item').each do |item|
            puts item.css('a')[0][:href].split('/').last
            urls.push("https://www.tiktok.com/embed/#{item.css('a')[0][:href].split('/').last}")
          end

          urls.uniq.each do |u|
            DataFromEmbedWorker.perform_async(u, false)
          end
          # Socksify::proxy("127.0.0.1", 9050) {
          #   url = URI.encode "https://www.tiktok.com/tag/#{tag.tag_title}"
          #   charset = nil
          #   html = open(url) do |f|
          #     charset = f.charset
          #     f.read
          #   end
          #   doc = Nokogiri::HTML.parse(html, nil, charset)
          #   embeds = []
          #   script = doc.css('script').to_s
          #   script.split('"embedUrl":"').drop(1).each do |n|
          #     embeds.push(n.split('","')[0])
          #   end
          #
          #   puts embeds.uniq
          #   embeds.uniq.each do |url|
          #     DataFromEmbedWorker.perform_async(url, false)
          #   end
          # }
        rescue => error
          driver.close
          driver.quit
          puts error
        end
      end
    end
    driver.close
    driver.quit
  end

  task :get_video_from_user => :environment do
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-setuid-sandbox')
    options.add_argument('--no-first-run')
    options.add_argument('--no-zygote')
    options.add_argument('--single-process')
    options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")
    driver = Selenium::WebDriver.for :chrome, options: options, http_client: client

    User.all.find_in_batches(batch_size: 10) do |users|
      users.reverse.each do |user|
        begin
          driver.get "https://www.tiktok.com/@#{user.user_sec_id}"
          doc = Nokogiri::HTML(driver.page_source)
          urls = []
          doc.css('._video_feed_item').each do |item|
            puts item.css('a')[0][:href].split('/').last
            urls.push("https://www.tiktok.com/embed/#{item.css('a')[0][:href].split('/').last}")
          end

          urls.uniq.each do |u|
            DataFromEmbedWorker.perform_async(u, false)
          end

          # Socksify::proxy("127.0.0.1", 9050) {
          #   url = URI.encode "https://www.tiktok.com/@#{user.user_sec_id}"
          #   charset = nil
          #   html = open(url) do |f|
          #     charset = f.charset
          #     f.read
          #   end
          #   doc = Nokogiri::HTML.parse(html, nil, charset)
          #   embeds = []
          #   script = doc.css('script').to_s
          #   script.split('"embedUrl":"').drop(1).each do |n|
          #     embeds.push(n.split('","')[0])
          #   end
          #
          #   puts embeds.uniq
          #   embeds.uniq.each do |url|
          #     DataFromEmbedWorker.perform_async(url, false)
          #   end
          # }
        rescue => error
          driver.close
          driver.quit
          puts error
        end
      end
    end
    driver.close
    driver.quit
  end

  task :get_trending => :environment do
    begin
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 120 # seconds
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--disable-gpu')
      options.add_argument('--disable-setuid-sandbox')
      options.add_argument('--no-first-run')
      options.add_argument('--no-zygote')
      options.add_argument('--single-process')
      options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")
      driver = Selenium::WebDriver.for :chrome, options: options, http_client: client
      driver.get "https://www.tiktok.com/trending"

      doc = Nokogiri::HTML(driver.page_source)

      urls = []

      puts doc.css('._video_feed_item')
      doc.css('._video_feed_item').each do |item|
        puts item.css('a')[0][:href].split('/').last
        urls.push("https://www.tiktok.com/embed/#{item.css('a')[0][:href].split('/').last}")
      end
      driver.close
      driver.quit

      urls.uniq.each do |u|
        DataFromEmbedWorker.perform_async(u, true)
      end

    rescue => error
      driver.close
      driver.quit
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

  task :test_get_video_from_task => :environment do
    Tag.all.each do |tag|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 120 # seconds
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")

      ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

      caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
      driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps
      driver.get "https://www.tiktok.com/trending"

      doc = Nokogiri::HTML(driver.page_source)

      urls = []
      doc.css('._video_feed_item').each do |item|
        puts item.css('a')[0][:href].split('/').last
        urls.push("https://www.tiktok.com/embed/#{item.css('a')[0][:href].split('/').last}")
      end
      puts urls.uniq.count
      #
      # urls.uniq.each do |u|
      #   DataFromEmbedWorker.perform_async(u, false)
      # end

      driver.close
      driver.quit
    end
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
    require 'open_uri_redirections'

    @videos = []
    Tag.all.find_in_batches(batch_size: 10) do |tags|
      tags.reverse.each do |tag|
        unless TagInflow.find_by(tag_id: tag.id).present?
          @inflow = TagInflow.create(tag_id: tag.id, youtube: true)
          puts "tagInflow youtube"
          puts @inflow.id

          sleep(1800000)
          Video.find_each do |v|
            if v.video_tags.try(:include?, tag.tag_title)
              @videos.push(v)
            end
          end
          unless @videos.nil?
            @videos.each do | video |
              open(video.video_url, :allow_redirections => :safe) do |file|
                open("./lib/tasks/v/#{video.id.to_s}.mp4", "w+b") do |out|
                  out.write(file.read)
                  system("ffmpeg -i ./lib/tasks/v/#{video.id.to_s}.mp4 -r 30 -c:v h264 -c:a libfdk_aac ./lib/tasks/m/#{video.id.to_s}.mp4")
                  system("echo file '/var/www/sample-test/current/lib/tasks/m/#{video.id.to_s}.mp4' >> ./lib/tasks/m/videos.txt")
                end
              end
            end

            @videos = []
            # system("find /var/www/sample-test/current/lib/tasks/m/*.mp4 | sed 's:\ :\\\ :g'| sed 's/^/file /' >/var/www/sample-test/current/lib/tasks/m/videos.txt")
            system("ffmpeg -f concat -safe 0 -i /var/www/sample-test/current/lib/tasks/m/videos.txt -y /var/www/sample-test/current/lib/tasks/m/output.mp4")
            # system("ffmpeg -f concat -safe 0 -i ./lib/tasks/m/videos.txt -y ./lib/tasks/m/output.mp4")
            Gc.authorize
            Gc.main(tag.tag_title)
            system("rm -rf ./lib/tasks/v/")
            system("mkdir ./lib/tasks/v/")
            system("rm -rf ./lib/tasks/m/")
            system("mkdir ./lib/tasks/m/")
          end
        else
          puts "あるでんて"
        end
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
