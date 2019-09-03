class WelcomeController < ApplicationController
  def index
    @trending_videos = Video.where(video_trending: true)
    @trending_tags = Tag.where(tag_trending: true)

    @videos = Video.eager_load(:user).where(video_trending: true).shuffle.take(30)
    @users = @videos.pluck(:user_id).uniq

    @videos_trend_all = Video.eager_load(:user).where(video_trending: true)
    @videos_trend_rank = @videos_trend_all.sort_by {|array| Integer(array.video_interaction_count)}.reverse

    @videos_all = Video.eager_load(:user)
    @videos_all_rank = @videos_all.sort_by {|array| Integer(array.video_interaction_count)}.reverse

  end
end
