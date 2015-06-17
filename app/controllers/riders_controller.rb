class RidersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_insurance, only: [:index, :new, :show, :edit, :create, :update, :destroy, :new_from_master, :create_from_master]
  before_action :set_rider, only: [:show, :edit, :update, :destroy]
  before_action :set_master_rider, only: [:show_master, :edit_master, :update_master, :destroy_master]
  before_action :breadcrumb, only: [:index, :show, :edit]
  before_action :breadcrumb_master, only: [:index_master, :show_master, :edit_master]

  # GET /riders
  # GET /riders.json
  def index
    page = params[:page] || 1
    @riders = @insurance.riders.page(page)
  end

  # GET /riders/1
  # GET /riders/1.json
  def show
  end

  # GET /riders/new
  def new
    copy_from_id = params[:uid]
    if copy_from_id != "" 
      cloned_rider = Rider.find_by_id(copy_from_id)
      if cloned_rider 
        attrs = cloned_rider.copied_attributes
        @rider = @insurance.riders.new(attrs)
      else
        @rider = @insurance.riders.new
      end
      
    else
      @rider = @insurance.riders.new
    end
  end

  # GET /riders/1/edit
  def edit
  end

  # POST /riders
  # POST /riders.json
  def create
    @rider = @insurance.riders.new(rider_params)

    respond_to do |format|
      if @rider.save
        # Deep clone coverage in the reference rider
        if rider_params[:reference_id] != ""
          reference_rider = Rider.find_by_id(rider_params[:reference_id])
          if reference_rider
            reference_rider.coverages.each do |coverage| 
              @rider.coverages <<  Coverage.new(name: coverage.name, description: coverage.description,
                                                assured_amount: coverage.assured_amount, description: coverage.category,
                                                premium_amount: coverage.premium_amount,
                                                premium_unit: coverage.premium_unit, coverage_unit: coverage.coverage_unit,
                                                coverage_end_at: coverage.coverage_end_at)
            end
          end
        end
        format.html { redirect_to [@rider.insurance, @rider], notice: 'Rider was successfully created.' }
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
        format.html { redirect_to [@rider.insurance, @rider], notice: 'Rider was successfully updated.' }
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
      format.html { redirect_to [@rider.insurance.book, @rider.insurance], notice: 'Rider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  # GET /riders/masters
  # GET /riders/masters.json
  def index_master
    page = params[:page] || 1
    @riders = Rider.master.page(page)
  end

  # GET /riders/1/master
  # GET /riders/1/master.json
  def show_master
  end

  # GET /riders/master_new
  def new_master
    @rider = Rider.new(rider_type: 'master')
  end

  # GET /riders/1/edit_master
  def edit_master
  end

  # POST /riders/create_master
  # POST /riders/create_master.json
  def create_master
    @rider = Rider.new(rider_params)
    @rider.rider_type = 'master'

    respond_to do |format|
      if @rider.save
        format.html { redirect_to master_rider_path(@rider), notice: 'Rider was successfully created.' }
        format.json { render :show_master, status: :created, location: @rider }
      else
        format.html { render :new_master }
        format.json { render json: @rider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /riders/update_master/1
  # PATCH/PUT /riders/update_master/1.json
  def update_master
    respond_to do |format|
      if @rider.update(rider_params)
        format.html { redirect_to master_rider_path(@rider), notice: 'Rider was successfully updated.' }
        format.json { render :show_master, status: :ok, location: @rider }
      else
        format.html { render :edit_master }
        format.json { render json: @rider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /riders/1/delete_master
  # DELETE /riders/1/delete_master.json
  def destroy_master
    @rider.destroy
    respond_to do |format|
      format.html { redirect_to masters_riders_path, notice: 'Rider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Get data and configurations for visualization
  def search
    tag_list = params[:tag_list]
    @riders = Rider.master.tagged_with(tag_list)
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb
    add_breadcrumb "Users", insured_users_path if @rider.insurance.book
    add_breadcrumb "Master insurance", master_riders_path if @rider.insurance.is_master?

    add_breadcrumb @rider.insurance.book.insured_user.first_name, insured_user_path(@rider.insurance.book.insured_user) if @rider.insurance.book
    add_breadcrumb @rider.insurance.book.number, insured_user_book_path(@rider.insurance.book.insured_user, @rider.insurance.book) if @rider.insurance.book
    if @rider.insurance.is_master?
      add_breadcrumb @rider.insurance.name, master_insurance_path(@rider.insurance) 
    else
      add_breadcrumb @rider.insurance.name, book_insurance_path(@rider.insurance.book, @rider.insurance)
    end
    add_breadcrumb @rider.name, insurance_rider_path(@rider.insurance, @rider) if @rider
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb_master
    add_breadcrumb "Master Rider", master_riders_path
    add_breadcrumb @rider.name, master_rider_path(@rider) if @rider
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rider
      @rider = Rider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rider_params
      params.require(:rider).permit(:name, :description, :status, :code_name, :reference_id, :tag_list)
    end

    def set_insurance
      @insurance = Insurance.find(params[:insurance_id])
    end

    def set_master_rider
      @rider = Rider.master.find(params[:id])
    end
end
