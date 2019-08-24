class User < ApplicationRecord
  has_many :videos

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

    driver.close
    driver.quit

    return user

  end
end
