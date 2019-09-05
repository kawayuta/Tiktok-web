class VideoJob < ApplicationJob
  queue_as :default

  def perform(search)
    puts "Video ジョブ実行"
    begin
      Tag.get_tag_from_keyword(search)
    rescue => error
      puts "Video 例外やで"
    end
  end
end
