class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :ranking]
  before_action :search_params, only: [:search]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show

    @trending_videos = cache_videos_trending.take(10)
    @trending_tags = cache_tags_trending.take(10)

    @videos_data = cache_videos
    @videos = @videos_data.select { |v| v.video_tags.include?(@tag.tag_title) unless v.video_tags.nil? }.shuffle!
    @videos_rank = @videos.sort_by {|array| Integer(array.video_interaction_count)}.first(10).reverse.to_a

    @tag_histries_posts_trans_views_count = cache_tags_histories.select {|h|h.tag_title == @tag.tag_title}.pluck(:created_at,:tag_views_count).map { |e| [ e[0].strftime("%Y-%m-%d"), e[1] ] }
    @tag_histries_posts_trans_posts_count = cache_tags_histories.select {|h|h.tag_title == @tag.tag_title}.pluck(:created_at,:tag_posts_count).map { |e| [ e[0].strftime("%Y-%m-%d"), e[1] ] }

  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search

    return redirect_to tag_path(1) if search_params[:keyword] == ""

    @tag = Tag.find_by(tag_title: search_params[:keyword])

    if @tag.nil?
      @tag = Tag.create(tag_title: search_params[:keyword])
      @tag.updated_at = "2000-01-01"
      @tag.tag_url = "https://www.tiktok.com/tag/#{search_params[:keyword]}?langCountry=ja"
      @tag.tag_trending = false
      @tag.save
    end

    if @tag.updated_at.strftime("%Y-%m-%d") != Time.current.strftime("%Y-%m-%d")
      VideoJob.perform_later(search_params[:keyword])
      @tag.updated_at = Time.current.strftime("%Y-%m-%d")
      @tag.save!
    end

    redirect_to tag_path(@tag.id)

  end

  def ranking
    @trending_videos = cache_videos_trending.take(10)
    @trending_tags = cache_tags_trending.take(10)

    @videos_data = cache_videos
    @videos = @videos_data.select { |v| v.video_tags.include?(@tag.tag_title) unless v.video_tags.nil? }

    @videos_interaction_rank = @videos.sort_by {|array| Integer(array.video_interaction_count)}.reverse.first(50)
    @videos_comment_rank = @videos.sort_by {|array| Integer(array.video_comment_count)}.reverse.first(50)
    @videos_share_rank = @videos.sort_by {|array| Integer(array.video_share_count)}.reverse.first(50)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:user_official_id, :user_nick_named)
    end

    def search_params
      params.permit(:keyword)
    end

    def cache_videos
      Rails.cache.fetch("cache_videos", expired_in: 720.minutes) do
        Video.eager_load(:user).all.to_a
      end
    end

    def cache_videos_trending
      Rails.cache.fetch("cache_videos_trending", expired_in: 720.minutes) do
        Video.eager_load(:user).where(video_trending: true).to_a
      end
    end

    def cache_tags_trending
      Rails.cache.fetch("cache_tags_trending", expired_in: 720.minutes) do
        Tag.where(tag_trending: true).to_a
      end
    end

    def cache_tags_histories
      Rails.cache.fetch("cache_tags_histories", expired_in: 720.minutes) do
        TagHistory.all.to_a
      end
    end

end
