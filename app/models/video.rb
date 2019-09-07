class Video < ApplicationRecord
  serialize :video_tags
  serialize :video_tags_official_ids

  belongs_to :user

  def self.update_video(official_id)
    @video = Video.find_by(video_official_id: official_id)
    begin
      ActiveRecord::Base.connection_pool.with_connection do
        if @video.updated_at.strftime("%Y-%m-%d") != Time.current.strftime("%Y-%m-%d")
          puts "update video"
          video = Video.get_video(official_id)
          @video.update(video)
        end
        unless VideoHistory.where(video_official_id: official_id, created_at: Time.current.strftime("%Y-%m-%d").in_time_zone.all_day).present?
          puts "create history"
          video = Video.get_video(official_id)
          @old = VideoHistory.create(video)
        end
      end
    rescue => error
    end
  end

  def self.get_video(official_id)
    begin
      Socksify::proxy("127.0.0.1", 9050) {
        url = URI.encode "https://www.tiktok.com/embed/#{official_id}"
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
        return video
      }
    rescue => error
      puts "TASK_DATABASE 例外やで"
    end

  end

end
