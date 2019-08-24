class Video < ApplicationRecord
  serialize :video_tags

  belongs_to :user

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

    driver.close
    driver.quit

    return video
  end

end
