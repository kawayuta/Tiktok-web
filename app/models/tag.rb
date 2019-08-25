class Tag < ApplicationRecord


  def self.new_tag(keyword)
    ActiveRecord::Base.connection_pool.with_connection do
      @tag = Tag.find_by(tag_title: keyword)
      unless @tag.nil?
        if @tag.updated_at.strftime("%Y-%m-%d") != Time.current.strftime("%Y-%m-%d")
          puts "update tag"
          tag = Tag.get_tag("https://www.tiktok.com/tag/#{keyword}?langCountry=ja")
          @tag = @tag.update(tag)
        else
          puts "load tag"
        end
      else
        puts "new tag"
        url = "https://www.tiktok.com/tag/#{keyword}?langCountry=ja"
        tag = Tag.get_tag(url)
        @tag = Tag.create(tag)
      end
    end

    return @tag
  end

  def self.get_tag_from_keyword(tag_instance)
    puts "new tag video"
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
    gt_driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps
    gt_driver.get tag_instance.tag_url

    doc = Nokogiri::HTML(gt_driver.page_source)
    gt_driver.close
    gt_driver.quit

    video_urls = []
    doc.css('._video_feed_item').each do |item|
      video_urls.push('https://www.tiktok.com' + item.css('a')[0][:href])
    end

    begin
      Parallel.each(video_urls.uniq, in_processes: 3) do |item_link|
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
          @video.update(video)
        else
          puts "new video"
          @user.videos.create(video)
        end

        # video[:video_tags].drop(1).each do |tag_id|
        #   tag = Tag.get_tag("https://www.tiktok.com/tag/#{tag_id}?langCountry=ja")
        #   unless Tag.find_by(tag_official_id: tag[:tag_official_id]).nil?
        #     puts "update tag"
        #     @tag = Tag.find_by(tag_official_id: tag[:tag_official_id])
        #     @tag.update(tag)
        #   else
        #     puts "new tag"
        #     Tag.create(tag)
        #   end
        #
        # end
        end

    rescue
      p "error"
    end
    video_urls = []

  end

  def self.get_tag(url)

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
    g_driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps
    g_driver.get url
    doc_tag = Nokogiri::HTML(g_driver.page_source)

    g_driver.close
    g_driver.quit

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

end
