class ProtectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_protection, only: [:show, :edit, :update, :destroy]
  before_action :set_insurance

  # GET /protections
  # GET /protections.json
  def index
    @protections = @insurance.protections.all
  end

  # GET /protections/1
  # GET /protections/1.json
  def show
  end

  # GET /protections/new
  def new
    @protection = @insurance.protections.new
  end

  # GET /protections/1/edit
  def edit
  end

  # POST /protections
  # POST /protections.json
  def create
    @protection = @insurance.protections.new(protection_params)

    respond_to do |format|
      if @protection.save
        format.html { redirect_to [@protection.insurance, @protection], notice: 'Protection was successfully created.' }
        format.json { render :show, status: :created, location: [@protection.insurance, @protection] }
      else
        format.html { render :new }
        format.json { render json: @protection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /protections/1
  # PATCH/PUT /protections/1.json
  def update
    respond_to do |format|
      if @protection.update(protection_params)
        format.html { redirect_to [@protection.insurance, @protection], notice: 'Protection was successfully updated.' }
        format.json { render :show, status: :ok, location: [@protection.insurance, @protection] }
      else
        format.html { render :edit }
        format.json { render json: @protection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /protections/1
  # DELETE /protections/1.json
  def destroy
    @protection.destroy
    respond_to do |format|
      format.html { redirect_to redirect_after_destroy(@protection), notice: 'Protection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect_after_destroy(d)
    if d.insurance.is_master?
      master_insurance_path(d.insurance)
    else
      book_insurance_path(d.insurance.book, d.insurance)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_protection
      @protection = Protection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def protection_params
      params.require(:protection).permit(:year, :age, :amount, :coverage_rate)
    end

    def set_insurance
      @insurance = Insurance.find(params[:insurance_id])
    end
end
