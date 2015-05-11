class MasterCoveragesController < ApplicationController
  before_action :set_master_rider
  before_action :set_master_coverage, only: [:show, :edit, :update, :destroy]

  # GET /master_coverages
  # GET /master_coverages.json
  def index
    @master_coverages = @master_rider.master_coverages.all
  end

  # GET /master_coverages/1
  # GET /master_coverages/1.json
  def show
  end

  # GET /master_coverages/new
  def new
    @master_coverage = @master_rider.master_coverages.new
  end

  # GET /master_coverages/1/edit
  def edit
  end

  # POST /master_coverages
  # POST /master_coverages.json
  def create
    @master_coverage = @master_rider.master_coverages.new(master_coverage_params)

    respond_to do |format|
      if @master_coverage.save
        format.html { redirect_to [@master_coverage.master_rider, @master_coverage], notice: 'Master coverage was successfully created.' }
        format.json { render :show, status: :created, location: @master_coverage }
      else
        format.html { render :new }
        format.json { render json: @master_coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_coverages/1
  # PATCH/PUT /master_coverages/1.json
  def update
    respond_to do |format|
      if @master_coverage.update(master_coverage_params)
        format.html { redirect_to [@master_coverage.master_rider, @master_coverage], notice: 'Master coverage was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_coverage }
      else
        format.html { render :edit }
        format.json { render json: @master_coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_coverages/1
  # DELETE /master_coverages/1.json
  def destroy
    @master_coverage.destroy
    respond_to do |format|
      format.html { redirect_to master_rider_path(@master_coverage.master_rider), notice: 'Master coverage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_coverage
      @master_coverage = MasterCoverage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_coverage_params
      params.require(:master_coverage).permit(:name, :description, :coverage_amount, :category, :master_rider_id, :abbr, :premium_amount, :premium_unit, :coverage_unit, :coverage_end_at)
    end

    def set_master_rider
      @master_rider = MasterRider.find(params[:master_rider_id])
    end
end
