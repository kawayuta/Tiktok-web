class VideoJob < ApplicationJob
  queue_as :default

  def perform(url)
    puts "Video ジョブ実行"
    Tag.get_video_from_embed_new(url)
  end
end
