class VideoJob < ApplicationJob
  queue_as :default

  def perform(url)
    puts "Video ジョブ実行"
    begin
      Tag.get_video_from_embed_new(url)
    rescue => error
      puts "Video 例外やで"
    end
  end
end
