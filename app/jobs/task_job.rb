class TaskJob < ApplicationJob
  queue_as :default

  def perform(url)
    puts "ジョブ実行"
    Tag.get_video_from_embed_task_new(url)
  end
end
