class WelcomeController < ApplicationController

  def index
    @trending_videos = cache_videos_trending.take(10)
    @trending_tags = cache_tags_trending.take(10)

    @videos_trend_all = cache_videos_trending_all
    @videos_trend_rank = @videos_trend_all.sort_by {|array| Integer(array.video_interaction_count) unless array.video_interaction_count.nil?}.reverse.first(10)

    @videos_data = cache_videos
    @videos_all_rank = @videos_data.sort_by {|array| Integer(array.video_interaction_count) unless array.video_interaction_count.nil? }.reverse.first(10)

    @videos = cache_videos_trending.shuffle.take(30)
    @recommend_tags = @videos.pluck(:video_tags).flatten.compact.uniq.sort.reverse
  end

  private

  def cache_videos
    Rails.cache.fetch("cache_videos", expired_in: 60.minutes) do
      Video.eager_load(:user).all.to_a
    end
  end

  def cache_videos_trending_all
    Rails.cache.fetch("cache_videos_trending_all", expired_in: 60.minutes) do
      Video.eager_load(:user).where(video_trending: true).to_a
    end
  end

  def cache_videos_trending
    Rails.cache.fetch("cache_videos_trending", expired_in: 60.minutes) do
      Video.eager_load(:user).where(video_trending: true).to_a
    end
  end

  def cache_tags_trending
    Rails.cache.fetch("cache_tags_trending", expired_in: 60.minutes) do
      Tag.where(tag_trending: true).to_a
    end
  end
end
