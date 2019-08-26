namespace :task_database do

  require 'nokogiri'
  require 'open-uri'
  require 'selenium-webdriver'
  require 'tor-privoxy'
  require 'socksify/http'

  task :get_tor => :environment do
    torrc = Tor::Config.load("/etc/tor/torrc")
    Tor::Config.open("/etc/tor/torrc") do |torrc|
      puts "Tor SOCKS port: #{torrc['SOCKSPort']}"
      puts "Tor control port: #{torrc['ControlPort']}"
      puts "Tor exit policy:"
      torrc.each('ExitPolicy') do |key, value|
        puts "  #{value}"
      end
    end
    Tor::Controller.connect(:port => 9050) do |tor|
      puts "Tor version: #{tor.version}"
      puts "Tor config file: #{tor.config_file}"
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
        @video_url = el.split('"url":"')[1].split('","')[0]
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

end
