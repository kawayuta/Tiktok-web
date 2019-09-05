class Tag < ApplicationRecord

  require 'nokogiri'
  require 'open-uri'
  require 'socksify'

  def self.new_tag(search)
    @tag = Tag.find_by(tag_title: search)
    begin
      unless @tag.nil?
        ActiveRecord::Base.connection_pool.with_connection do
          if @tag.updated_at.strftime("%Y-%m-%d") != Time.current.strftime("%Y-%m-%d") && @tag.updated_at.strftime("%Y-%m-%d") != "2001-01-01"
            puts "update tag"
            tag = Tag.get_tag("https://www.tiktok.com/tag/#{search}")
            @tag.update(tag)
            @tag.updated_at = "2001-01-01"
            @tag.save!
          end
          unless TagHistory.where(tag_title: search, created_at: Time.current.strftime("%Y-%m-%d").in_time_zone.all_day).present?
            puts "update history"
            tag = Tag.get_tag("https://www.tiktok.com/tag/#{search}")
            @old = TagHistory.create(tag)
          end
        end
      else
        ActiveRecord::Base.connection_pool.with_connection do
          puts "new tag & histories"
          tag = Tag.get_tag("https://www.tiktok.com/tag/#{search}")
          @tag = Tag.create(tag)
          @old = TagHistory.create(tag)
        end
      end
    rescue => error
    end
  end

  def self.get_tag_from_keyword(search)
    begin

      Socksify::proxy("127.0.0.1", 9050) {
        url = URI.encode "https://www.tiktok.com/tag/#{search}"
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

        embeds.each do |url|
          VideoJob.perform_later(url)
        end
      }
    rescue => error
    end

  end

  def self.get_video_from_embed_task_new(url)

    Socksify::proxy("127.0.0.1", 9050) {
      url = URI.encode url
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read
      end
      doc = Nokogiri::HTML.parse(html, nil, charset)
    a = doc.css('script').to_s
    @video_official_id = a.split('"id":"')[1].split('","')[0] unless a.split('"id":"')[1].nil?
    @video_interaction_count = a.split('"diggCount":')[1].split(',"')[0] unless a.split('"diggCount":')[1].nil?
    @video_share_count = a.split('"shareCount":')[1].split(',"')[0] unless a.split('"shareCount":')[1].nil?
    @video_comment_count = a.split('"commentCount":')[1].split(',"')[0] unless a.split('"commentCount":')[1].nil?
    @video_url = "https://tiktok.com/node/video/playwm?id=#{@video_official_id}" unless @video_official_id.nil?
    @video_cover_url = a.split('"urlsOrigin":["')[1].split('"],"')[0] unless a.split('"urlsOrigin":["')[1].nil?

    @video_text_title = a.split('"text":"')[1].split('","')[0].split('#')[0] unless a.split('"text":"')[1].nil?
    @video_tags_title = a.split('"text":"')[1].split('","')[0].split('#').drop(1).map(&:strip!).compact! unless a.split('"text":"')[1].nil?
    @video_user_official_id = a.split('"secUid":"')[1].split('","')[0] unless a.split('"secUid":"')[1].nil?
    @video_user_nick_name = a.split('"nickName":"')[1].split('","')[0] unless a.split('"nickName":"')[1].nil?
    @video_user_cover = a.split('"avatarUriOrigin":["')[1].split('"],"')[0] unless a.split('"avatarUriOrigin":["')[1].nil?

    user = {
        "user_official_id": @video_user_official_id,
        "user_nick_name": @video_user_nick_name,
        "user_covers": @video_user_cover,
    }

    video = {
        "video_url": @video_url,
        "video_official_id": @video_official_id,
        "video_title": @video_text_title,
        "video_tags": @video_tags_title,
        "video_comment_count": @video_comment_count,
        "video_share_count": @video_share_count,
        "video_interaction_count": @video_interaction_count,
        "video_cover_image": @video_cover_url,
        "video_trending": true
    }


    unless User.find_by(user_official_id: user[:user_official_id]).nil?
      ActiveRecord::Base.connection_pool.with_connection do
        puts "update user"
        @user = User.find_by(user_official_id: user[:user_official_id])
        @user.update(user)
      end
    else
      ActiveRecord::Base.connection_pool.with_connection do
        @user = User.create(user)
        puts "new user"
      end

    end

    unless @user.videos.find_by(video_official_id: video[:video_official_id]).nil?
      ActiveRecord::Base.connection_pool.with_connection do
        puts "update video"
        @video = @user.videos.find_by(video_official_id: video[:video_official_id])
        @video.update(video)
      end
    else
      ActiveRecord::Base.connection_pool.with_connection do
        @video = @user.videos.create(video)
      end
    end

    unless @video_tags_title.nil?
      @video_tags_title.each do |tag|
        tag = {
            "tag_title": tag,
            "tag_url": "https://www.tiktok.com/tag/#{tag}",
            "tag_trending": "true"
        }
        @tag = Tag.find_by(tag_title: tag[:tag_title])
        unless @tag.nil?
          @tag.update(tag)
        else
          @tag = Tag.create(tag)
        end
        @tag.updated_at = "2000-01-01"
        @tag.save!
      end
    end
    }

  end

  def self.get_video_from_embed_new(url)

    Socksify::proxy("127.0.0.1", 9050) {
    url = URI.encode url
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    a = doc.css('script').to_s
    @video_official_id = a.split('"id":"')[1].split('","')[0] unless a.split('"id":"')[1].nil?
    @video_interaction_count = a.split('"diggCount":')[1].split(',"')[0] unless a.split('"diggCount":')[1].nil?
    @video_share_count = a.split('"shareCount":')[1].split(',"')[0] unless a.split('"shareCount":')[1].nil?
    @video_comment_count = a.split('"commentCount":')[1].split(',"')[0] unless a.split('"commentCount":')[1].nil?
    @video_url = "https://tiktok.com/node/video/playwm?id=#{@video_official_id}" unless @video_official_id.nil?
    @video_cover_url = a.split('"urlsOrigin":["')[1].split('"],"')[0] unless a.split('"urlsOrigin":["')[1].nil?

    @video_text_title = a.split('"text":"')[1].split('","')[0].split('#')[0] unless a.split('"text":"')[1].nil?
    @video_tags_title = a.split('"text":"')[1].split('","')[0].split('#').drop(1).map(&:strip!).compact! unless a.split('"text":"')[1].nil?
    @video_user_official_id = a.split('"secUid":"')[1].split('","')[0] unless a.split('"secUid":"')[1].nil?
    @video_user_nick_name = a.split('"nickName":"')[1].split('","')[0] unless a.split('"nickName":"')[1].nil?
    @video_user_cover = a.split('"avatarUriOrigin":["')[1].split('"],"')[0] unless a.split('"avatarUriOrigin":["')[1].nil?

    user = {
        "user_official_id": @video_user_official_id,
        "user_nick_name": @video_user_nick_name,
        "user_covers": @video_user_cover,
    }

    video = {
        "video_url": @video_url,
        "video_official_id": @video_official_id,
        "video_title": @video_text_title,
        "video_tags": @video_tags_title,
        "video_comment_count": @video_comment_count,
        "video_share_count": @video_share_count,
        "video_interaction_count": @video_interaction_count,
        "video_cover_image": @video_cover_url,
        "video_trending": false
    }

    unless User.find_by(user_official_id: user[:user_official_id]).nil?
      ActiveRecord::Base.connection_pool.with_connection do
        puts "update user"
        @user = User.find_by(user_official_id: user[:user_official_id])
        @user.update(user)
      end
    else
      ActiveRecord::Base.connection_pool.with_connection do
        @user = User.create(user)
        puts "new user"
      end

    end

    unless @user.videos.find_by(video_official_id: video[:video_official_id]).nil?
      ActiveRecord::Base.connection_pool.with_connection do
        puts "update video"
        @video = @user.videos.find_by(video_official_id: video[:video_official_id])
        @video.update(video)
      end
    else
      ActiveRecord::Base.connection_pool.with_connection do
        puts "create video"
        @video = @user.videos.create(video)
      end
    end

    unless @video_tags_title.nil?
      @video_tags_title.each do |tag|
        tag = {
            "tag_title": tag,
            "tag_url": "https://www.tiktok.com/tag/#{tag}",
            "tag_trending": "false"
        }
        @tag = Tag.find_by(tag_title: tag[:tag_title])
        unless @tag.nil?
          @tag.update(tag)
        else
          @tag = Tag.create(tag)
          @tag.updated_at = "2000-01-01"
          @tag.save!
        end
      end
    end
    }

  end

  def self.get_video_from_embed_task(url, driver)
    driver.get url
    doc = Nokogiri::HTML(driver.page_source)

    if doc.css('title').text != "TikTok"
      a = doc.search('script').to_s
      @video_official_id = a.split('"id":"')[1].split('","')[0] unless a.split('"id":"')[1].nil?
      # @video_user_official_id = a.split('"userId":"')[1].split('","')[0]
      @video_interaction_count = a.split('"diggCount":')[1].split(',"')[0] unless a.split('"diggCount":')[1].nil?
      @video_share_count = a.split('"shareCount":')[1].split(',"')[0] unless a.split('"shareCount":')[1].nil?
      @video_comment_count = a.split('"commentCount":')[1].split(',"')[0] unless a.split('"commentCount":')[1].nil?
      # @video_url = a.split('"url":["')[1].split('"],"')[0].split('","')[1] unless js.split('challengeId":')[1].nil?
      @video_url = "https://tiktok.com#{doc.css('#tiktokVideo')[0][:src]}"
      @video_cover_url = a.split('"urlsOrigin":["')[1].split('"],"')[0] unless a.split('"urlsOrigin":["')[1].nil?
      # @video_music_official_id = a.split('"musicId":"')[1].split('"],"')[0]
      @video_text_title = a.split('"text":"')[1].split('","')[0].split('#')[0] unless a.split('"text":"')[1].nil?
      @video_tags_title = a.split('"text":"')[1].split('","')[0].split('#').drop(1).map(&:strip!).compact! unless a.split('"text":"')[1].nil?
      @video_user_official_id = a.split('"secUid":"')[1].split('","')[0] unless a.split('"secUid":"')[1].nil?
      @video_user_nick_name = a.split('"nickName":"')[1].split('","')[0] unless a.split('"nickName":"')[1].nil?
      @video_user_cover = a.split('"avatarUriOrigin":["')[1].split('"],"')[0] unless a.split('"avatarUriOrigin":["')[1].nil?
      # @video_music_name = a.split('musicName":"')[1].split('","')[0]
      # @video_music_author_name = a.split('"authorName":"')[1].split('","')[0]
      # @video_music_cover = a.split('"cover_hd":"')[1].split('","')[0]

      user = {
          "user_official_id": @video_user_official_id,
          "user_nick_name": @video_user_nick_name,
          "user_covers": @video_user_cover,
      }

      video = {
          "video_url": @video_url,
          "video_official_id": @video_official_id,
          "video_title": @video_text_title,
          "video_tags": @video_tags_title,
          "video_comment_count": @video_comment_count,
          "video_share_count": @video_share_count,
          "video_interaction_count": @video_interaction_count,
          "video_cover_image": @video_cover_url,
          "video_trending": true
      }

      unless User.find_by(user_official_id: user[:user_official_id]).nil?
        ActiveRecord::Base.connection_pool.with_connection do
          puts "update user"
          @user = User.find_by(user_official_id: user[:user_official_id])
          @user.update(user)
        end
      else
        ActiveRecord::Base.connection_pool.with_connection do
          @user = User.create(user)
          puts "new user"
        end

      end

      unless @user.videos.find_by(video_official_id: video[:video_official_id]).nil?
        ActiveRecord::Base.connection_pool.with_connection do
          puts "update video"
          @video = @user.videos.find_by(video_official_id: video[:video_official_id])
          @video.update(video)
        end
      else
        ActiveRecord::Base.connection_pool.with_connection do
          @video = @user.videos.create(video)
        end
      end

      unless @video_tags_title.nil?
        @video_tags_title.each do |tag|
          tag = {
              "tag_title": tag,
              "tag_url": "https://www.tiktok.com/tag/#{tag}?langCountry=ja",
              "tag_trending": "true"
          }

          puts tag[:tag_title]
          @tag = Tag.find_by(tag_title: tag[:tag_title])
          unless @tag.nil?
            @tag.update(tag)
          else
            @tag = Tag.create(tag)
          end
          @tag.updated_at = "2000-01-01"
          @tag.save!
        end
      end

    end

  end

  def self.get_video_from_embed(url, driver)
    driver.get url
    doc = Nokogiri::HTML(driver.page_source)

    if doc.css('title').text != "TikTok"
      a = doc.search('script').to_s
      @video_official_id = a.split('"id":"')[1].split('","')[0] unless a.split('"id":"')[1].nil?
      # @video_user_official_id = a.split('"userId":"')[1].split('","')[0]
      @video_interaction_count = a.split('"diggCount":')[1].split(',"')[0] unless a.split('"diggCount":')[1].nil?
      @video_share_count = a.split('"shareCount":')[1].split(',"')[0] unless a.split('"shareCount":')[1].nil?
      @video_comment_count = a.split('"commentCount":')[1].split(',"')[0] unless a.split('"commentCount":')[1].nil?
      # @video_url = a.split('"url":["')[1].split('"],"')[0].split('","')[1] unless js.split('challengeId":')[1].nil?
      @video_url = "https://tiktok.com#{doc.css('#tiktokVideo')[0][:src]}"
      @video_cover_url = a.split('"urlsOrigin":["')[1].split('"],"')[0] unless a.split('"urlsOrigin":["')[1].nil?
      # @video_music_official_id = a.split('"musicId":"')[1].split('"],"')[0]
      @video_text_title = a.split('"text":"')[1].split('","')[0].split('#')[0] unless a.split('"text":"')[1].nil?
      @video_tags_title = a.split('"text":"')[1].split('","')[0].split('#').drop(1).map(&:strip!).compact! unless a.split('"text":"')[1].nil?
      @video_user_official_id = a.split('"secUid":"')[1].split('","')[0] unless a.split('"secUid":"')[1].nil?
      @video_user_nick_name = a.split('"nickName":"')[1].split('","')[0] unless a.split('"nickName":"')[1].nil?
      @video_user_cover = a.split('"avatarUriOrigin":["')[1].split('"],"')[0] unless a.split('"avatarUriOrigin":["')[1].nil?
      # @video_music_name = a.split('musicName":"')[1].split('","')[0]
      # @video_music_author_name = a.split('"authorName":"')[1].split('","')[0]
      # @video_music_cover = a.split('"cover_hd":"')[1].split('","')[0]

      user = {
          "user_official_id": @video_user_official_id,
          "user_nick_name": @video_user_nick_name,
          "user_covers": @video_user_cover,
      }

      video = {
          "video_url": @video_url,
          "video_official_id": @video_official_id,
          "video_title": @video_text_title,
          "video_tags": @video_tags_title,
          "video_comment_count": @video_comment_count,
          "video_share_count": @video_share_count,
          "video_interaction_count": @video_interaction_count,
          "video_cover_image": @video_cover_url,
          "video_trending": false
      }

      unless User.find_by(user_official_id: user[:user_official_id]).nil?
        ActiveRecord::Base.connection_pool.with_connection do
          puts "update user"
          @user = User.find_by(user_official_id: user[:user_official_id])
          @user.update(user)
        end
      else
        ActiveRecord::Base.connection_pool.with_connection do
          @user = User.create(user)
          puts "new user"
        end

      end

      unless @user.videos.find_by(video_official_id: video[:video_official_id]).nil?
        ActiveRecord::Base.connection_pool.with_connection do
          puts "update video"
          @video = @user.videos.find_by(video_official_id: video[:video_official_id])
          @video.update(video)
        end
      else
        ActiveRecord::Base.connection_pool.with_connection do
          puts "create video"
          @video = @user.videos.create(video)
        end
      end

      # unless @video_tags_title.nil?
      #   @video_tags_title.each do |tag|
      #     @tag = {
      #         "tag_title": tag,
      #         "tag_url": "https://www.tiktok.com/tag/#{tag}?langCountry=ja",
      #         "tag_trending": "false"
      #     }
      #   end
      # end

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
    return tag
    }
  end

  def self.old_arg

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1,1')
    # options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
    driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps

    driver.closee
    driver.quit
  end
end
