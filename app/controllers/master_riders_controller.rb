class MasterRidersController < ApplicationController
  before_action :set_master_rider, only: [:show, :edit, :update, :destroy]

  # GET /master_riders
  # GET /master_riders.json
  def index
    @master_riders = MasterRider.all
  end

  # GET /master_riders/1
  # GET /master_riders/1.json
  def show
  end

  # GET /master_riders/new
  def new
    @master_rider = MasterRider.new
    # Default end date to nil
    @master_rider.end_at = nil
  end

  # GET /master_riders/1/edit
  def edit
  end

  # POST /master_riders
  # POST /master_riders.json
  def create
    @master_rider = MasterRider.new(master_rider_params)

    respond_to do |format|
      if @master_rider.save
        format.html { redirect_to @master_rider, notice: 'Master rider was successfully created.' }
        format.json { render :show, status: :created, location: @master_rider }
      else
        format.html { render :new }
        format.json { render json: @master_rider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_riders/1
  # PATCH/PUT /master_riders/1.json
  def update
    respond_to do |format|
      if @master_rider.update(master_rider_params)
        format.html { redirect_to @master_rider, notice: 'Master rider was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_rider }
      else
        format.html { render :edit }
        format.json { render json: @master_rider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_riders/1
  # DELETE /master_riders/1.json
  def destroy
    @master_rider.destroy
    respond_to do |format|
      format.html { redirect_to master_riders_url, notice: 'Master rider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_rider
      @master_rider = MasterRider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_rider_params
      params.require(:master_rider).permit(:name, :begin_at, :end_at, :description, :status, :code_name)
    end
end
