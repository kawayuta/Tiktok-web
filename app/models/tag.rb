class Tag < ApplicationRecord

  require 'nokogiri'
  require 'open-uri'
  require 'socksify'

  def self.new_tag(search)
    begin
      tag_instance = Tag.find_by(tag_title: search)
      unless tag_instance.nil?
        tag_data = Tag.get_tag("https://www.tiktok.com/tag/#{search}")
        return if tag_data[:tag_official_id].nil?

        ActiveRecord::Base.connection_pool.with_connection do
            puts "update tag"
            tag_instance.update(tag_data)
        end
        unless TagHistory.where(tag_title: search, created_at: Time.current.strftime("%Y-%m-%d").in_time_zone.all_day).present?
          ActiveRecord::Base.connection_pool.with_connection do
            puts "create history"
            TagHistory.create(tag_data)
          end
        end
      else
        ActiveRecord::Base.connection_pool.with_connection do
          puts "new tag & histories"
          tag_data = Tag.get_tag("https://www.tiktok.com/tag/#{search}")
          return if tag_data[:tag_official_id].nil?

          tag_instance = Tag.create(tag_data)
          tag_instance.updated_at = "2000-01-01"
          tag_instance.save

          ActiveRecord::Base.connection_pool.with_connection do
            hash = Tag.group(:tag_official_id).having('count(*) >= 2').maximum(:id)
            Tag.where(tag_official_id: hash.keys).where.not(id: hash.values).destroy_all
          end
        end
      end

      return tag_instance

    rescue => error
      TagUpdateWorker.perform_async(search)
    end
  end
  def self.get_tag(url)
    Socksify::proxy("127.0.0.1", 9050) {
      url = URI.encode url
      charset = nil

      html = open(url) do |f|
        charset = f.charset
        f.read
      end

      doc = Nokogiri::HTML.parse(html, nil, charset)

      js = doc.search('script').to_s
      tag_official_id = js.split('challengeId":')[1].split(',')[0].delete('"') unless js.split('challengeId":')[1].nil?
      tag_title = js.split('challengeName":')[1].split(',')[0].delete('"') unless js.split('challengeName":')[1].nil?
      tag_text = js.split('","text":"')[1].split(',')[0].delete('"') unless js.split('","text":"')[1].nil?
      tag_cover_image = js.split('covers":')[1].split(',')[0].delete('["').delete('"]') unless js.split('covers":')[1].nil?
      tag_posts_count = js.split('posts":')[2].split(',')[0] unless js.split('posts":')[2].nil?
      tag_views_count = js.split('views":')[2].split(',')[0].delete('"').delete('}') unless js.split('views":')[2].nil?
      tag_url = url

      tag = {
          "tag_official_id": tag_official_id,
          "tag_title": tag_title,
          "tag_text": tag_text,
          "tag_cover_image": tag_cover_image,
          "tag_posts_count": tag_posts_count,
          "tag_views_count": tag_views_count,
          "tag_url": tag_url
      }
      return tag
    }
  end

  def self.get_data_from_keyword(search)
    begin
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
      driver.get "https://www.tiktok.com/tag/#{search}"
      doc = Nokogiri::HTML(driver.page_source)

      urls = []
      doc.css('._video_feed_item').each do |item|
        puts item.css('a')[0][:href].split('/').last
        urls.push("https://www.tiktok.com/embed/#{item.css('a')[0][:href].split('/').last}")
      end

      urls.uniq.each do |u|
        DataFromEmbedWorker.perform_async(u, false)
      end

      driver.close
      driver.quit
    rescue => error
      driver.close
      driver.quit
    end

  end

  def self.get_data_from_embed(url, is_trending)
    begin
      Socksify::proxy("127.0.0.1", 9050) {
        url = URI.encode url
        charset = nil
        html = open(url) do |f|
          charset = f.charset
          f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        a = doc.css('script').to_s
        video_official_id = a.split('"id":"')[1].split('","')[0] unless a.split('"id":"')[1].nil?
        video_tags_title = a.split('"text":"')[1].split('","')[0].split('#').drop(1).map(&:strip!).compact! unless a.split('"text":"')[1].nil?
        user_official_id = a.split('"userId":"')[1].split('","')[0] unless a.split('"userId":"')[1].nil?

        user_instance = User.new_user(user_official_id)
        video_instance = Video.new_video(video_official_id, user_instance)
        video_instance.video_trending = is_trending
        video_instance.save!

        unless video_tags_title.nil?
          video_tags_title.each do |tag|
            tag_instance = Tag.new_tag(tag)
            tag_instance.tag_trending = is_trending
            tag_instance.save!
          end
        end
      }
    rescue => error
      DataFromEmbedWorker.perform_async(url, is_trending)
    end
  end

end
