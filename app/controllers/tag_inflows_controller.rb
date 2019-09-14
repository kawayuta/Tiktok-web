class TagInflowsController < ApplicationController
  before_action :set_tag_inflow, only: [:show, :edit, :update, :destroy]

  # GET /tag_inflows
  # GET /tag_inflows.json
  def index
    @tag_inflows = TagInflow.all
  end

  # GET /tag_inflows/1
  # GET /tag_inflows/1.json
  def show
  end

  # GET /tag_inflows/new
  def new
    @tag_inflow = TagInflow.new
  end

  # GET /tag_inflows/1/edit
  def edit
  end

  # POST /tag_inflows
  # POST /tag_inflows.json
  def create
    @tag_inflow = TagInflow.new(tag_inflow_params)

    respond_to do |format|
      if @tag_inflow.save
        format.html { redirect_to @tag_inflow, notice: 'Tag inflow was successfully created.' }
        format.json { render :show, status: :created, location: @tag_inflow }
      else
        format.html { render :new }
        format.json { render json: @tag_inflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_inflows/1
  # PATCH/PUT /tag_inflows/1.json
  def update
    respond_to do |format|
      if @tag_inflow.update(tag_inflow_params)
        format.html { redirect_to @tag_inflow, notice: 'Tag inflow was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag_inflow }
      else
        format.html { render :edit }
        format.json { render json: @tag_inflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_inflows/1
  # DELETE /tag_inflows/1.json
  def destroy
    @tag_inflow.destroy
    respond_to do |format|
      format.html { redirect_to tag_inflows_url, notice: 'Tag inflow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_inflow
      @tag_inflow = TagInflow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_inflow_params
      params.require(:tag_inflow).permit(:tag, :youtube)
    end
end
