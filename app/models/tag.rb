class Tag < ApplicationRecord

  def self.new_tag(search)
    @tag = Tag.find_by(tag_title: search)
    unless @tag.nil?
      if @tag.updated_at.strftime("%Y-%m-%d") != Time.current.strftime("%Y-%m-%d")
        ActiveRecord::Base.connection_pool.with_connection do
          puts "update tag"
          tag = Tag.get_tag("https://www.tiktok.com/tag/#{search}?langCountry=ja")
          @tag = @tag.update(tag)
        end
      end
    else
      ActiveRecord::Base.connection_pool.with_connection do
        puts "new tag"
        url = "https://www.tiktok.com/tag/#{search}?langCountry=ja"
        tag = Tag.get_tag(url)
        @tag = Tag.create(tag)
      end
    end
  end

  def self.get_tag_from_keyword(search)
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
    driver.get "https://www.tiktok.com/tag/#{search}?langCountry=ja"

    doc = Nokogiri::HTML(driver.page_source)
    elements = doc.search('script')[13].to_s.split('name":"').drop(1)
    driver.close
    driver.quit

    @tag = Tag.find_by(tag_title: search)


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
            ActiveRecord::Base.connection_pool.with_connection do
              @user = User.find_by(user_official_id: user[:user_official_id])
              @user.update(user)
            end
          else
            ActiveRecord::Base.connection_pool.with_connection do
              @user = User.create(user)
              puts "new user"
            end
          end

          video.delete(:user_official_id)
          unless @user.videos.find_by(video_official_id: video[:video_official_id]).nil?
            ActiveRecord::Base.connection_pool.with_connection do
              puts "update video"
              @video = @user.videos.find_by(video_official_id: video[:video_official_id])
              @video.update(video)
            end

          else
            ActiveRecord::Base.connection_pool.with_connection do
              puts "new video"
              @user.videos.create(video)
            end

          end

          video[:video_tags].each do |tag|
            ActiveRecord::Base.connection_pool.with_connection do
              @tag = tag.gsub(/[[:space:]]/, '')
              if Tag.find_by(tag_title: @tag).nil?
                Tag.create(tag_title: @tag, tag_url: "https://www.tiktok.com/tag/#{@tag}?langCountry=ja")
              end
            end
          end

    end

  end

  def self.get_tag(url)
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
    g_driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps
    g_driver.get url
    doc_tag = Nokogiri::HTML(g_driver.page_source)

    g_driver.close
    g_driver.quit

    js = doc_tag.search('script')[7].text
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
