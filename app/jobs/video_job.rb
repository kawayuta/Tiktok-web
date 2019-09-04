class VideoJob < ApplicationJob
  queue_as :default

  def perform(keyword)
    puts "ジョブ実行"
    Tag.get_tag_from_keyword(keyword)
  end
end
