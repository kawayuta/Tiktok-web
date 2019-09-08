class User < ApplicationRecord

  require 'nokogiri'
  require 'open-uri'
  require 'socksify'

  has_many :videos

  def self.new_user(user_official_id)
    begin
      user_instance = User.find_by(user_official_id: user_official_id)
      unless user_instance.nil?
        user_data = User.get_user(user_official_id)
        return if user_data[:user_official_id].nil?

        ActiveRecord::Base.connection_pool.with_connection do
          puts "update user"
          user_instance.update(user_data)
        end
        unless UserHistory.where(user_official_id: user_official_id, created_at: Time.current.strftime("%Y-%m-%d").in_time_zone.all_day).present?
          ActiveRecord::Base.connection_pool.with_connection do
            puts "create history"
            UserHistory.create(user_data)
          end
        end
      else
        ActiveRecord::Base.connection_pool.with_connection do
          puts "new user & histories"
          user_data = User.get_user(user_official_id)
          return if user_data[:user_official_id].nil?

          user_instance = User.create(user_data)
          UserHistory.create(user_data)

          ActiveRecord::Base.connection_pool.with_connection do
            hash = User.group(:user_official_id).having('count(*) >= 2').maximum(:id)
            User.where(user_official_id: hash.keys).where.not(id: hash.values).destroy_all
          end

          ActiveRecord::Base.connection_pool.with_connection do
            hash = UserHistory.group(:user_official_id).having('count(*) >= 2').maximum(:id)
            UserHistory.where(user_official_id: hash.keys).where.not(id: hash.values).destroy_all
          end
        end
      end

      return user_instance
    rescue => error
      UserUpdateWorker.perform_async(user_official_id)
    end
  end

  def self.get_user(user_official_id)
    begin
      Socksify::proxy("127.0.0.1", 9050) {
        url = URI.encode "https://m.tiktok.com/h5/share/usr/#{user_official_id}"
        charset = nil
        html = open(url) do |f|
          charset = f.charset
          f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)

        js = doc.css('script').to_s
        user_url = js.split('fullUrl":')[1].split(',')[0].delete('"').delete('}') unless js.split('fullUrl":')[1].nil?
        user_user_id = js.split('userId":')[1].split(',')[0].delete('"') unless js.split('userId":')[1].nil?
        user_user_sec_id = js.split('secUid":"')[1].split(',')[0].delete('"') unless js.split('secUid":"')[1].nil?
        user_user_unique_id = js.split('uniqueId":"')[1].split(',')[0].delete('"') unless js.split('uniqueId":')[1].nil?
        user_nick_name = js.split('nickName":')[1].split(',')[0].delete('"') unless js.split('nickName":')[1].nil?
        user_signature = js.split('signature":')[1].split(',')[0].delete('"') unless js.split('signature":')[1].nil?
        user_covers = js.split('covers":')[1].split(',')[0].delete('["').delete('"]') unless js.split('covers":')[1].nil?
        user_following_count = js.split('following":')[1].split(',')[0].delete('"') unless js.split('following":')[1].nil?
        user_fans_count = js.split('fans":')[1].split(',')[0].delete('"') unless js.split('fans":')[1].nil?
        user_heart_count = js.split('heart":')[1].split(',')[0].delete('"') unless js.split('heart":')[1].nil?
        user_verified = js.split('verified":')[1].split(',')[0].delete('"') unless js.split('verified":')[1].nil?

        user = {
            "user_official_id": user_user_id,
            "user_unique_id": user_user_unique_id,
            "user_sec_id": user_user_sec_id,
            "user_nick_name": user_nick_name,
            "user_signature": user_signature,
            "user_covers": user_covers,
            "user_following_count": user_following_count,
            "user_fans_count": user_fans_count,
            "user_heart_count": user_heart_count,
            "user_verified": user_verified,
            "user_url": "https://www.tiktok.com/@#{user_user_sec_id}"
        }
        return user
      }
    rescue => error
      puts "TASK_DATABASE 例外やで"
    end

  end
end
