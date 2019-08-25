class Video < ApplicationRecord
  serialize :video_tags

  belongs_to :user

  def self.get_video(url)
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120 # seconds
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--proxy-server=%s' % "socks5://127.0.0.1:9050")
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/local/bin/chromedriver', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x800"]})
    v_driver = Selenium::WebDriver.for :chrome, options: options, http_client: client, desired_capabilities: caps
    v_driver.get url
    doc_item = Nokogiri::HTML(v_driver.page_source)
    v_driver.close
    v_driver.quit

    tags = doc_item.css('._video_card_big_meta_info_challenge')
    @video_tags = tags.search("a").text.split('#')

    title = doc_item.css('._video_card_big_meta_info_title')
    title.search("a").each(&:remove)
    @video_title = title.text

    js = doc_item.search('script').to_s
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

end
