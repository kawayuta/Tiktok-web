namespace :task_database do

  require 'nokogiri'
  require 'open-uri'
  require 'selenium-webdriver'

  task :get_trending => :environment do
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
        @video.update(video)
      else
        puts "new video"
        @user.videos.create(video)
      end

      video[:video_tags].drop(1).each do |tag_id|
        tag = get_tag("https://www.tiktok.com/tag/#{tag_id}?langCountry=ja")
        unless Tag.find_by(tag_official_id: tag[:tag_official_id]).nil?
          puts "update tag"
          @tag = Tag.find_by(tag_official_id: tag[:tag_official_id])
          @tag.update(tag)
        else
          puts "new tag"
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

  def self.get_video(url)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.get url
    doc_item = Nokogiri::HTML(driver.page_source)

    tags = doc_item.css('._video_card_big_meta_info_challenge')
    @video_tags = tags.search("a").text.split('#')

    title = doc_item.css('._video_card_big_meta_info_title')
    title.search("a").each(&:remove)
    @video_title = title.text

    js = doc_item.search('script')[11].text
    @user_official_id = js.split('userId":')[1].split(',')[0].delete('"')
    @user_unique_id = js.split('uniqueId":')[1].split(',')[0].delete('"')
    @user_nickname = js.split('nickName":')[1].split(',')[0]

    @video_source = js.split('urls":')[1].split(',')[0].delete('["').delete('"]')
    @video_comment_count = js.split('commentCount":')[1].split(',')[0]
    @video_play_count = js.split('diggCount":')[1].split(',')[0]
    @video_share_count = js.split('shareCount":')[1].split(',')[0]
    @video_cover_image = js.split('coversOrigin":')[1].split(',')[0].delete('["').delete('"]')
    @video_url = url
    @video_official_id = url.split('/').last

    video = {
        "user_official_id": @user_official_id,
        "user_unique_id": @user_unique_id,
        "user_nickname": @user_nickname,
        "video_source": @video_source,
        "video_official_id": @video_official_id,
        "video_title": @video_title,
        "video_tags": @video_tags,
        "video_comment_count": @video_comment_count,
        "video_play_count": @video_play_count,
        "video_share_count": @video_share_count,
        "video_cover_image": @video_cover_image,
        "video_url": @video_url,
    }

    return video
  end

  def self.get_tag(url)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.get url
    doc_tag = Nokogiri::HTML(driver.page_source)

    js = doc_tag.search('script')[13].text
    @tag_official_id = js.split('challengeId":')[1].split(',')[0].delete('"')
    @tag_title = js.split('challengeName":')[1].split(',')[0].delete('"')
    @tag_text = js.split('text":')[1].split(',')[0].delete('"')
    @tag_cover_image = js.split('covers":')[1].split(',')[0].delete('["').delete('"]')
    @tag_posts_count = js.split('posts":')[1].split(',')[0]
    @tag_views_count = js.split('views":')[1].split(',')[0].delete('"').delete('}')
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

    return tag

  end

  def self.get_user(url)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.get url
    doc_tag = Nokogiri::HTML(driver.page_source)

    js = doc_tag.search('script')[13].text
    @user_os = js.split('os":')[1].split(',')[0].delete('"')
    @user_region = js.split('region":')[1].split(',')[0].delete('"')
    @user_url = js.split('fullUrl":')[1].split(',')[0].delete('"').delete('}')
    @user_user_id = js.split('userId":')[1].split(',')[0].delete('"')
    @user_nick_name = js.split('nickName":')[1].split(',')[0].delete('"')
    @user_signature = js.split('signature":')[1].split(',')[0].delete('"')
    @user_covers = js.split('covers":')[1].split(',')[0].delete('["').delete('"]')
    @user_following_count = js.split('following":')[1].split(',')[0].delete('"')
    @user_fans_count = js.split('fans":')[1].split(',')[0].delete('"')
    @user_heart_count = js.split('heart":')[1].split(',')[0].delete('"')
    @user_video_count = js.split('video":')[1].split(',')[0].delete('"')
    @user_verified = js.split('verified":')[1].split(',')[0].delete('"')

    user = {
        "user_official_id": @user_user_id,
        "user_nick_name": @user_nick_name,
        "user_signature": @user_signature,
        "user_covers": @user_covers,
        "user_following_count": @user_following_count,
        "user_fans_count": @user_fans_count,
        "user_heart_count": @user_heart_count,
        "user_video_count": @user_video_count,
        "user_verified": @user_verified,
        "user_region": @user_region,
        "user_url": @user_url
    }

    return user

  end

  def self.has_mb?(str)
    str.bytes do |b|
      return true if  (b & 0b10000000) != 0
    end
    false
  end

end
