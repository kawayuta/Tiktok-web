class VideoHistoriesController < ApplicationController
  before_action :set_video_history, only: [:show, :edit, :update, :destroy]

  # GET /video_histories
  # GET /video_histories.json
  def index
    @video_histories = VideoHistory.all
  end

  # GET /video_histories/1
  # GET /video_histories/1.json
  def show
  end

  # GET /video_histories/new
  def new
    @video_history = VideoHistory.new
  end

  # GET /video_histories/1/edit
  def edit
  end

  # POST /video_histories
  # POST /video_histories.json
  def create
    @video_history = VideoHistory.new(video_history_params)

    respond_to do |format|
      if @video_history.save
        format.html { redirect_to @video_history, notice: 'Video history was successfully created.' }
        format.json { render :show, status: :created, location: @video_history }
      else
        format.html { render :new }
        format.json { render json: @video_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /video_histories/1
  # PATCH/PUT /video_histories/1.json
  def update
    respond_to do |format|
      if @video_history.update(video_history_params)
        format.html { redirect_to @video_history, notice: 'Video history was successfully updated.' }
        format.json { render :show, status: :ok, location: @video_history }
      else
        format.html { render :edit }
        format.json { render json: @video_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_histories/1
  # DELETE /video_histories/1.json
  def destroy
    @video_history.destroy
    respond_to do |format|
      format.html { redirect_to video_histories_url, notice: 'Video history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video_history
      @video_history = VideoHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_history_params
      params.require(:video_history).permit(:user_official_id)
    end
end
