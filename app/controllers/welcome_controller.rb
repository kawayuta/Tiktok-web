class WelcomeController < ApplicationController
  def index
    Rails.cache.fetch("cache_videos_trending", expired_in: 60.minutes) do
      @trending_videos = Video.where(video_trending: true).limit(10).to_a
      @trending_tags = Tag.where(tag_trending: true).limit(10).to_a
    end

    Rails.cache.fetch("cache_videos_trending_all", expired_in: 60.minutes) do
      @videos_trend_all = Video.eager_load(:user).where(video_trending: true).to_a
      @videos_trend_rank = @videos_trend_all.sort_by {|array| Integer(array.video_interaction_count)}.reverse.first(10)
    end

    Rails.cache.fetch("cache_videos_welcomeController_index", expired_in: 60.minutes) do
      @videos_data = Video.eager_load(:user).all
    end

      @videos = @videos_data.where(video_trending: true).shuffle.take(30).to_a
      @users = @videos.pluck(:user_id).uniq

      @videos_all_rank = @videos_data.sort_by {|array| Integer(array.video_interaction_count)}.reverse.first(10)

  end
end
