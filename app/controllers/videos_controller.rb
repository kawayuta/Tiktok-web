class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @trending_videos = cache_videos_trending.take(10)
    @trending_tags = cache_tags_trending.take(10)

    @videos = cache_videos_near
    puts @videos

    @video_histries_posts_interaction_count = cache_videos_histories.select {|h|h.video_official_id == @video.video_official_id}.pluck(:created_at,:video_interction_count).map { |e| [ e[0].strftime("%Y-%m-%d"), e[1] ] }
    @video_histries_posts_share_count = cache_videos_histories.select {|h|h.video_official_id == @video.video_official_id}.pluck(:created_at,:video_share_count).map { |e| [ e[0].strftime("%Y-%m-%d"), e[1] ] }
    @video_histries_posts_comment_count = cache_videos_histories.select {|h|h.video_official_id == @video.video_official_id}.pluck(:created_at,:video_comment_count).map { |e| [ e[0].strftime("%Y-%m-%d"), e[1] ] }
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:user_official_id, :user_unique_id)
    end

  def cache_videos_near
    ids = (@video.id.to_i - 10)..10
    Video.eager_load(:user).where(id:ids.to_a)
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

  def cache_videos_histories
    VideoHistory.all.to_a
    # Rails.cache.fetch("cache_tags_histories", expired_in: 60.minutes) do
    # end
  end
end
