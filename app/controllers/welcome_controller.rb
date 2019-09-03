class WelcomeController < ApplicationController
  def index
    Rails.cache.fetch("cache_videos_trending", expired_in: 60.minutes) do
      @trending_videos = Video.where(video_trending: true).to_a
      @trending_tags = Tag.where(tag_trending: true).to_a
    end

    @videos = Video.eager_load(:user).where(video_trending: true).shuffle.take(30)
    @users = @videos.pluck(:user_id).uniq

    Rails.cache.fetch("cache_videos_trending_all", expired_in: 60.minutes) do
      @videos_trend_all = Video.eager_load(:user).where(video_trending: true).to_a
    end
    @videos_trend_rank = @videos_trend_all.sort_by {|array| Integer(array.video_interaction_count)}.reverse

    Rails.cache.fetch("cache_videos", expired_in: 60.minutes) do
      @videos_data = Video.eager_load(:user).all.to_a
    end
    @videos_all_rank = @videos_data.sort_by {|array| Integer(array.video_interaction_count)}.reverse

  end
end
