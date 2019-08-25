class VideoJob < ApplicationJob
  queue_as :default

  def perform(args)
    puts "VIDEO ジョブが実行されたよ！＼(^o^)／"

    video = Video.get_video(args)
    user = User.get_user("https://www.tiktok.com/@#{video[:user_unique_id]}")
    unless User.find_by(user_official_id: user[:user_official_id]).nil?
      puts "update user"
      @user = User.find_by(user_official_id: user[:user_official_id])
      @user.update(user)
    else
      @user = User.create(user)
      puts "new user"
    end

    video.delete(:user_official_id)
    video.delete(:user_unique_id)
    video.delete(:user_nickname)
    unless @user.videos.find_by(video_official_id: video[:video_official_id]).nil?
      puts "update video"
      @video = @user.videos.find_by(video_official_id: video[:video_official_id])
      @video.update(video)
    else
      puts "new video"
      @user.videos.create(video)
    end

  end
end
