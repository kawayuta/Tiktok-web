namespace :task_database do

  require 'nokogiri'
  require 'open-uri'
  require 'selenium-webdriver'

  task :get_trending => :environment do
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    driver = Selenium::WebDriver.for :chrome, options: options, http_client: client
    driver.get "https://www.tiktok.com/ja/trending"

    doc = Nokogiri::HTML(driver.page_source)
    video_urls = []
    doc.css('._video_feed_item').each do |item|
      video_urls.push('https://www.tiktok.com' + item.css('a')[0][:href])
    end

    video_urls.uniq.each do |item_link|
      video = Video.get_video(item_link)

      user = User.get_user("https://www.tiktok.com/@#{video[:user_unique_id]}")
      unless User.find_by(user_official_id: user[:user_official_id]).nil?
        puts "update user"
        @user = User.find_by(user_official_id: user[:user_official_id])
        @user.update(user)
      else
        @user = User.create(user)
        puts "new user"
      end

      video.delete(:user_official_id)
      video.delete(:user_unique_id)
      video.delete(:user_nickname)
      unless @user.videos.find_by(video_official_id: video[:video_official_id]).nil?
        puts "update video"
        @video = @user.videos.find_by(video_official_id: video[:video_official_id])
        video[:video_trending] = false
        @video.update(video)
      else
        puts "new video"
        video[:video_trending] = true
        @user.videos.create(video)
      end

      video[:video_tags].drop(1).each do |tag_id|
        tag = Tag.get_tag("https://www.tiktok.com/tag/#{tag_id}?langCountry=ja")
        unless Tag.find_by(tag_official_id: tag[:tag_official_id]).nil?
          puts "update tag"
          @tag = Tag.find_by(tag_official_id: tag[:tag_official_id])
          tag[:tag_trending] = false
          @tag.update(tag)
        else
          puts "new tag"
          tag[:tag_trending] = true
          Tag.create(tag)
        end

      end

    end
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
