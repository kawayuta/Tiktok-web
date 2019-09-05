class TaskJob < ApplicationJob
  queue_as :default

  def perform(url)
    puts "TASK ジョブ実行"
    begin
      Tag.get_video_from_embed_task_new(url)
    rescue => error
      puts "TASK 例外やで"
    end
  end
end
