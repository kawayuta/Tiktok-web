class TagJob < ApplicationJob
  queue_as :default

  def perform(title)
    puts "TAG ジョブが実行されたよ！＼(^o^)／"
    begin
      Tag.new_tag(title)
    rescue => error
      puts "TAG 例外やで"
    end
  end
end
