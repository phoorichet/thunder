class DividendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dividend, only: [:show, :edit, :update, :destroy]
  before_action :set_insurance

  # GET /dividends
  # GET /dividends.json
  def index
    @dividends = @insurance.dividends.all
  end

  # GET /dividends/1
  # GET /dividends/1.json
  def show
  end

  # GET /dividends/new
  def new
    @dividend = @insurance.dividends.new
  end

  # GET /dividends/1/edit
  def edit
  end

  # POST /dividends
  # POST /dividends.json
  def create
    @dividend = @insurance.dividends.new(dividend_params)

    respond_to do |format|
      if @dividend.save
        format.html { redirect_to [@dividend.insurance, @dividend], notice: 'Dividend was successfully created.' }
        format.json { render :show, status: :created, location: [@dividend.insurance, @dividend] }
      else
        format.html { render :new }
        format.json { render json: @dividend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dividends/1
  # PATCH/PUT /dividends/1.json
  def update
    respond_to do |format|
      if @dividend.update(dividend_params)
        format.html { redirect_to [@dividend.insurance, @dividend], notice: 'Dividend was successfully updated.' }
        format.json { render :show, status: :ok, location: [@dividend.insurance, @dividend] }
      else
        format.html { render :edit }
        format.json { render json: @dividend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dividends/1
  # DELETE /dividends/1.json
  def destroy
    @dividend.destroy
    respond_to do |format|
      format.html { redirect_to insurance_url(@dividend.insurance), notice: 'Dividend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dividend
      @dividend = Dividend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dividend_params
      params.require(:dividend).permit(:year, :age, :amount)
    end

     def set_insurance
      @insurance = Insurance.find(params[:insurance_id])
    end
end
