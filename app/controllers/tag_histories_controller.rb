class TagHistoriesController < ApplicationController
  before_action :set_tag_history, only: [:show, :edit, :update, :destroy]

  # GET /tag_histories
  # GET /tag_histories.json
  def index
    @tag_histories = TagHistory.all
  end

  # GET /tag_histories/1
  # GET /tag_histories/1.json
  def show
  end

  # GET /tag_histories/new
  def new
    @tag_history = TagHistory.new
  end

  # GET /tag_histories/1/edit
  def edit
  end

  # POST /tag_histories
  # POST /tag_histories.json
  def create
    @tag_history = TagHistory.new(tag_history_params)

    respond_to do |format|
      if @tag_history.save
        format.html { redirect_to @tag_history, notice: 'Tag history was successfully created.' }
        format.json { render :show, status: :created, location: @tag_history }
      else
        format.html { render :new }
        format.json { render json: @tag_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_histories/1
  # PATCH/PUT /tag_histories/1.json
  def update
    respond_to do |format|
      if @tag_history.update(tag_history_params)
        format.html { redirect_to @tag_history, notice: 'Tag history was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag_history }
      else
        format.html { render :edit }
        format.json { render json: @tag_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_histories/1
  # DELETE /tag_histories/1.json
  def destroy
    @tag_history.destroy
    respond_to do |format|
      format.html { redirect_to tag_histories_url, notice: 'Tag history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_history
      @tag_history = TagHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_history_params
      params.require(:tag_history).permit(:user_official_id, :user_nick_named)
    end
end
