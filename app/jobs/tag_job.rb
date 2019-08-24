class TagJob < ApplicationJob
  queue_as :default

  def perform(args)
    puts "TAG ジョブが実行されたよ！＼(^o^)／"
    Tag.new_tag(args)
  end
end
