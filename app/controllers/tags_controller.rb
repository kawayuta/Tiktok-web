class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :search_params, only: [:search]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show

    @trending_videos = Video.where(video_trending: true)
    @trending_tags = Tag.where(tag_trending: true)

    @videos = []
    Video.all.each do | video |
      unless video.video_tags.nil?
        @videos.push(video) if video.video_tags.include?(@tag.tag_title)
      end
    end

    if @videos.count < 30
      unless @videos.nil?
        @tags = @videos.pluck(:video_tags)

        @add_videos = []
        @tags.uniq.each do |tags|
          tags.uniq.each do |tag|
            Video.all.each do | video |
              unless video.video_tags.nil?
                @add_videos.push(video) if video.video_tags.include?(tag)
              end
            end
          end
        end

        unless @videos.nil? && @add_videos.nil?
          @videos.shuffle!
          @videos.concat(@add_videos.first(50)).uniq!
        end

      end

    end

    @users = @videos.pluck(:user_id).uniq

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
      Thread.new do
        # Tag.new_tag(search_params[:keyword])
      end

      Thread.new do
        Tag.get_tag_from_keyword(search_params[:keyword])
      end
      @tag.updated_at = Time.current.strftime("%Y-%m-%d")
      @tag.save!
    end

    redirect_to tag_url(@tag.id)


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
end
