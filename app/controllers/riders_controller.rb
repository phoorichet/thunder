class RidersController < ApplicationController
  before_action :set_contract
  before_action :set_rider, only: [:show, :edit, :update, :destroy]
  before_action :set_master_rider, only: [:create_from_master]

  # GET /riders
  # GET /riders.json
  def index
    @riders = @contract.riders.all
  end

  # GET /riders/1
  # GET /riders/1.json
  def show
  end

  # GET /riders/new
  def new
    @rider = @contract.riders.new
  end

  # GET /riders/new_from_master
  def new_from_master
    @rider = @contract.riders.new
  end

  # GET /riders/1/edit
  def edit
  end

  # POST /riders
  # POST /riders.json
  def create
    @rider = @contract.riders.new(rider_params)

    respond_to do |format|
      if @rider.save
        format.html { redirect_to [@rider.contract, @rider], notice: 'Rider was successfully created.' }
        format.json { render :show, status: :created, location: @rider }
      else
        format.html { render :new }
        format.json { render json: @rider.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /riders_from_master
  # POST /riders_from_master.json
  def create_from_master
    @rider = @contract.riders.new(rider_params)


    respond_to do |format|
      if @rider.save
        @master_rider.master_coverages.each do |coverage| 
          @rider.coverages <<  Coverage.new(name: coverage.name, description: coverage.description,
                                            coverage_amount: coverage.coverage_amount, description: coverage.category,
                                            abbr: coverage.abbr, premium_amount: coverage.premium_amount,
                                            premium_unit: coverage.premium_unit, coverage_unit: coverage.coverage_unit,
                                            coverage_end_at: coverage.coverage_end_at)
        end

        format.html { redirect_to [@rider.contract, @rider], notice: 'Rider was successfully created.' }
        format.json { render :show, status: :created, location: @rider }
      else
        format.html { render :new }
        format.json { render json: @rider.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /riders/1
  # PATCH/PUT /riders/1.json
  def update
    respond_to do |format|
      if @rider.update(rider_params)
        format.html { redirect_to [@rider.contract, @rider], notice: 'Rider was successfully updated.' }
        format.json { render :show, status: :ok, location: @rider }
      else
        format.html { render :edit }
        format.json { render json: @rider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /riders/1
  # DELETE /riders/1.json
  def destroy
    @rider.destroy
    respond_to do |format|
      format.html { redirect_to [@rider.contract.insured_user, @rider.contract], notice: 'Rider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rider
      @rider = Rider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rider_params
      params.require(:rider).permit(:name, :description, :status, :code_name, :master_rider_id)
    end

    def set_contract
      @contract = Contract.find(params[:contract_id])
    end

    def set_master_rider
      @master_rider = MasterRider.find(rider_params[:master_rider_id])
    end
end
