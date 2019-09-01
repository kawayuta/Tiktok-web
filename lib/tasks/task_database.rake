namespace :task_database do

  require 'nokogiri'
  require 'open-uri'
  require 'selenium-webdriver'
  require 'tor-privoxy'
  require 'socksify/http'

  task :get_tr => :environment do
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
    elements = doc.search('script').to_s.split('name":"').drop(1)
    driver.close
    driver.quit

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

    Parallel.map(urls.uniq!, in_processes: 3) do |u|
      Tag.get_video_from_embed_task(u)
    end
  end


  task :get_trending => :environment do
    # agent = Mechanize.new
    # page = agent.get("https://www.tiktok.com/ja/trending")
    # elements = page.search('script')[8].to_s.split('name":"').drop(1)
    #
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
    driver.get "https://www.tiktok.com/ja/trending"

    doc = Nokogiri::HTML(driver.page_source)
    elements = doc.search('script')[13].to_s.split('name":"').drop(1)
    driver.close
    driver.quit

    elements.each do |el|
      @user_nick_name = el.split(' on TikTok:')[0].split('(@')[0]

      @video_source = el.split('contentUrl":"')[1].split('","')[0]
      @video_cover_image = el.split('thumbnailUrl":["')[1].split('","')[0]
      @video_title = el.split(' on TikTok: ')[1].split('has created a short video on TikTok with music Dirty Work.')[0].split('","')[0].split("#")[0]
      @video_tags = el.split(' on TikTok: ')[1].split('has created a short video on TikTok with music Dirty Work.')[0].split('","')[0].split("#")
      @video_comment_count = el.split('commentCount":"')[1].split('"')[0]
      @video_interaction_count = el.split('interactionCount":"')[1].split('"')[0]
      unless el.split('"url":"')[1].nil?
        @video_official_id = @video_url.split('/').last
        @video_user_id = @video_url.split('/')[3]

        @user_official_id = @video_user_id
      else
        @video_url = ""
        @vide_id = ""
        @vide_user_id = ""
      end

    user = {
        "user_official_id": @user_official_id,
        "user_nick_name": @user_nick_name
    }

    video = {
        "user_official_id": @user_official_id,
        "video_source": @video_source,
        "video_official_id": @video_official_id,
        "video_title": @video_title,
        "video_tags": @video_tags,
        "video_comment_count": @video_comment_count,
        "video_play_count": @video_play_count,
        "video_share_count": @video_share_count,
        "video_interaction_count": @video_interaction_ount,
        "video_cover_image": @video_cover_image,
        "video_url": @video_url
    }

      unless User.find_by(user_official_id: user[:user_official_id]).nil?
        puts "update user"
        @user = User.find_by(user_official_id: user[:user_official_id])
        @user.update(user)
      else
        @user = User.create(user)
        puts "new user"
      end

      video.delete(:user_official_id)
      unless @user.videos.find_by(video_official_id: video[:video_official_id]).nil?
        puts "update video"
        @video = @user.videos.find_by(video_official_id: video[:video_official_id])
        @video.update(video)
      else
        puts "new video"
        @user.videos.create(video)
      end

      video[:video_tags].each do |tag|
        @tag = tag.gsub(/[[:space:]]/, '')
        if Tag.find_by(tag_title: @tag).nil?
          Tag.create(tag_title: @tag, tag_url: "https://www.tiktok.com/tag/#{@tag}?langCountry=ja")
        end
      end

    end

    # client = Selenium::WebDriver::Remote::Http::Default.new
    # client.read_timeout = 120 # seconds
    # options = Selenium::WebDriver::Chrome::Options.new
    # options.add_argument('--headless')
    # options.add_argument('--no-sandbox')
    # options.add_argument('--disable-dev-shm-usage')
    #
    # if Rails.env == 'production'
    #   options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")
    # end
    # ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"
    #
    # caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
    # driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps
    # driver.get "https://www.tiktok.com/ja/trending"
    #
    # doc = Nokogiri::HTML(driver.page_source)
    # driver.close
    # driver.quit
    # puts doc.search('script').to_s
    # # Parallel.each(items.uniq.first(10), in_processes: 3) do |item|
    #   # video = Video.get_video("https://www.tiktok.com#{item.css('a')[0][:href]}")
    #
    #
    #
    #   # video_cover = item.css('._avatar_').to_s.split('"')[3]
    #   #
    #   # user_name = item.css('a')[0][:href].split('/')[1]
    #   # user_official_id = item.css('a')[0][:href].split('/')[3]
    #   # user_covers = item.css('._avatar_').to_s.split('"')[3]
    #   #
    #   #
    #   # puts image
    #   # puts user_official_id
    #
    # end

  end

  task :get_trending_video => :environment do
    VIDEO_DATAS = []

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.get "https://www.tiktok.com/ja/trending"

    doc = Nokogiri::HTML(driver.page_source)
    video_urls = []
    doc.css('._video_feed_item').each do |item|
      video_urls.push('https://www.tiktok.com' + item.css('a')[0][:href])
    end

    video_urls.uniq.each do |item_link|
      video = get_video(item_link)
      VIDEO_DATAS.push(video)
      puts "[loading]" + video[:video_title]
    end
    video_urls = []

    VIDEO_DATAS.each do |video_data|
      # video_create
      puts "[save]" + video_data
    end
  end

  task :get_trending_tag => :environment do
    TAG_DATAS = []

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.get "https://www.tiktok.com/ja/trending"

    doc = Nokogiri::HTML(driver.page_source)

    tag_urls = []
    doc.css('._list_item_title').each do |item|
      tag_urls.push('https://www.tiktok.com' + item.css('a')[0][:href])
    end

    tag_urls.uniq.each do |item_link|
      tag = get_tag(item_link)
      TAG_DATAS.push(tag)
      puts "[loading]" + tag[:tag_title]
    end
    tag_urls = []

    video_urls = []
    doc.css('._video_feed_item').each do |item|
      video_urls.push('https://www.tiktok.com' + item.css('a')[0][:href])
    end

    video_urls.uniq.each do |item_link|
      video = get_video(item_link)
      video[:video_tags].drop(1).each do |tag_id|
        tag = get_tag("https://www.tiktok.com/tag/#{tag_id}?langCountry=ja")
        TAG_DATAS.push(tag)
        puts "[loading]" + tag[:tag_title]
      end
    end
    video_urls = []

    TAG_DATAS.each do |tag_data|
      # tag_create
      puts "[save]" + tag_data
    end
  end

  task :get_trending_user => :environment do
    USER_DATAS = []

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.get "https://www.tiktok.com/ja/trending"

    doc = Nokogiri::HTML(driver.page_source)

    video_urls = []
    doc.css('._video_feed_item').each do |item|
      video_urls.push('https://www.tiktok.com' + item.css('a')[0][:href])
    end

    video_urls.uniq.each do |item_link|
      video = get_video(item_link)
      user = get_user("https://www.tiktok.com/@#{video[:user_unique_id]}")
      puts "[loading]" + user[:user_nick_name]
      USER_DATAS.push(user)
    end
    video_urls = []

    USER_DATAS.each do |user_data|
      # user_create
      puts "[save]" + user_data
    end
  end

  def self.has_mb?(str)
    str.bytes do |b|
      return true if  (b & 0b10000000) != 0
    end
    false
  end

  task :upload_youtube => :environment do
    Gc.main("test")
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
    user_id = 'user_sever'
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
    path = "./lib/tasks/m/output.mp4"
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
              system("ffmpeg -i ./lib/tasks/v/#{video.id.to_s}.mp4 -r 30 -c:v h264 -c:a aac ./lib/tasks/m/#{video.id.to_s}.mp4")
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
