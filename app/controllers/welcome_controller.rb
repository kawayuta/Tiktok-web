class WelcomeController < ApplicationController
  def index
    @trending_videos = Video.where(video_trending: true)
    @trending_tags = Tag.where(tag_trending: true)

    @videos = Video.eager_load(:user).where(video_trending: true)
    @users = @videos.pluck(:user_id).uniq
  end
end
