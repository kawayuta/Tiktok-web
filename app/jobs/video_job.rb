class VideoJob < ApplicationJob
  queue_as :default

  def perform(args)
    puts "VIDEO ジョブが実行されたよ！＼(^o^)／"

    Tag.get_tag_from_keyword(args)

  end
end
