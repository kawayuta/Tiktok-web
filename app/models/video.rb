class Video < ApplicationRecord

  require 'nokogiri'
  require 'open-uri'
  require 'socksify'

  serialize :video_tags
  serialize :video_tags_official_ids

  belongs_to :user

  def self.new_video(video_official_id, user_instance)
    begin
      video_instance = Video.find_by(video_official_id: video_official_id)
      unless video_instance.nil?
        video_data = Video.get_video(video_official_id)
        return if video_data[:video_official_id].nil?

        ActiveRecord::Base.connection_pool.with_connection do
          puts "update video"
          video_instance.update(video_data)
        end
        unless VideoHistory.where(video_official_id: video_official_id, created_at: Time.current.strftime("%Y-%m-%d").in_time_zone.all_day).present?
          ActiveRecord::Base.connection_pool.with_connection do
            puts "create history"
            VideoHistory.create(video_data)
          end
        end
      else
        ActiveRecord::Base.connection_pool.with_connection do
          puts "new video & histories"
          video_data = Video.get_video(video_official_id)
          return if video_data[:video_official_id].nil?

          video_instance = user_instance.videos.create(video_data)

          ActiveRecord::Base.connection_pool.with_connection do
            hash = Video.group(:video_official_id).having('count(*) >= 2').maximum(:id)
            Video.where(video_official_id: hash.keys).where.not(id: hash.values).destroy_all
          end
        end
      end

      return video_instance
    rescue => error
      VideoUpdateWorker.perform_async(video_official_id, user_instance)
    end
  end

  def self.get_video(video_official_id)
    begin
      Socksify::proxy("127.0.0.1", 9050) {
        url = URI.encode "https://www.tiktok.com/embed/#{video_official_id}"
        charset = nil
        html = open(url) do |f|
          charset = f.charset
          f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)

        a = doc.css('script').to_s
        video_official_id = a.split('"id":"')[1].split('","')[0] unless a.split('"id":"')[1].nil?
        video_interaction_count = a.split('"diggCount":')[1].split(',"')[0] unless a.split('"diggCount":')[1].nil?
        video_share_count = a.split('"shareCount":')[1].split(',"')[0] unless a.split('"shareCount":')[1].nil?
        video_comment_count = a.split('"commentCount":')[1].split(',"')[0] unless a.split('"commentCount":')[1].nil?
        video_url = "https://tiktok.com/node/video/playwm?id=#{video_official_id}" unless video_official_id.nil?
        video_cover_url = a.split('"urlsOrigin":["')[1].split('"],"')[0] unless a.split('"urlsOrigin":["')[1].nil?

        video_text_title = a.split('"text":"')[1].split('","')[0].split('#')[0] unless a.split('"text":"')[1].nil?
        video_tags_title = a.split('"text":"')[1].split('","')[0].split('#').drop(1).map(&:strip!).compact! unless a.split('"text":"')[1].nil?

        video = {
            "video_url": video_url,
            "video_official_id": video_official_id,
            "video_title": video_text_title,
            "video_tags": video_tags_title,
            "video_comment_count": video_comment_count,
            "video_share_count": video_share_count,
            "video_interaction_count": video_interaction_count,
            "video_cover_image": video_cover_url,
            "video_trending": false
        }
        return video
      }
    rescue => error
      puts "TASK_DATABASE 例外やで"
    end

  end

end
