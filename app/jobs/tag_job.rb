class TagJob < ApplicationJob
  queue_as :default

  def perform(url)
    puts "TAG ジョブが実行されたよ！＼(^o^)／"
  end
end
