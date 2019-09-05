class TagJob < ApplicationJob
  queue_as :default

  def perform(title)
    puts "TAG ジョブが実行されたよ！＼(^o^)／"
    Tag.new_tag(title)
  end
end
