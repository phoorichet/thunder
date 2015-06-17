class CoveragesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rider, only: [:index, :new, :show, :edit, :create, :update, :destroy]
  before_action :set_coverage, only: [:show, :edit, :update, :destroy, 
                                      :show_master, :edit_master, :update_master, :destroy_master]
  before_action :breadcrumb, only: [:index, :show, :edit]
  before_action :breadcrumb_master, only: [:index_master, :show_master, :edit_master]


  # GET /coverages
  # GET /coverages.json
  def index
    page = params[:page] || 1
    @coverages = @rider.coverages.page(page)
  end

  # GET /coverages/1
  # GET /coverages/1.json
  def show
  end

  # GET /coverages/new
  def new
    copy_from_id = params[:uid]
    if copy_from_id != ""
      cloned_coverage = Coverage.find_by_id(copy_from_id)
      if cloned_coverage 
        attrs = cloned_coverage.copied_attributes
        @coverage = @rider.coverages.new(attrs)
      else
        @coverage = @rider.coverages.new
      end
      
    else
      @coverage = @rider.coverages.new
    end
    
  end

  # GET /coverages/1/edit
  def edit
  end

  # POST /coverages
  # POST /coverages.json
  def create
    @coverage = @rider.coverages.new(coverage_params)

    respond_to do |format|
      if @coverage.save
        format.html { redirect_to [@coverage.rider, @coverage], notice: 'Coverage was successfully created.' }
        format.json { render :show, status: :created, location: @coverage }
      else
        format.html { render :new }
        format.json { render json: @coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coverages/1
  # PATCH/PUT /coverages/1.json
  def update
    respond_to do |format|
      if @coverage.update(coverage_params)
        format.html { redirect_to [@coverage.rider, @coverage], notice: 'Coverage was successfully updated.' }
        format.json { render :show, status: :ok, location: @coverage }
      else
        format.html { render :edit }
        format.json { render json: @coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coverages/1
  # DELETE /coverages/1.json
  def destroy
    @coverage.destroy
    respond_to do |format|

      format.html { redirect_to redirect_after_destroy(@coverage.rider), notice: 'Coverage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect_after_destroy(rider)
    if rider.is_master?
      master_rider_path(rider)
    elsif rider.insurance
      insurance_rider_path(rider.insurance, rider)
    else
      rider_path(rider)
    end

  end


  # GET /coverages/master
  # GET /coverages/master.json
  def index_master
    page = params[:page] || 1
    @coverages = Coverage.master.page(page)
  end

  # GET /coverages/1/master
  # GET /coverages/1/master.json
  def show_master
  end

  # GET /coverages/new_master
  def new_master
    @coverage = Coverage.new
    @coverage.coverage_type = 'master'
  end

  # GET /coverages/1/edit_master
  def edit_master
  end

  # POST /coverages/master
  # POST /coverages/master.json
  def create_master
    @coverage = Coverage.new(coverage_params)
    @coverage.coverage_type = 'master'

    respond_to do |format|
      if @coverage.save
        format.html { redirect_to master_coverage_path(@coverage), notice: 'Coverage was successfully created.' }
        format.json { render :show_master, status: :created, location: @coverage }
      else
        format.html { render :new_master }
        format.json { render json: @coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coverages/1
  # PATCH/PUT /coverages/1.json
  def update_master
    respond_to do |format|
      if @coverage.update(coverage_params)
        format.html { redirect_to master_coverage_path(@coverage), notice: 'Coverage was successfully updated.' }
        format.json { render :show_master, status: :ok, location: @coverage }
      else
        format.html { render :edit_master }
        format.json { render json: @coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coverages/1
  # DELETE /coverages/1.json
  def destroy_master
    @coverage.destroy
    respond_to do |format|
      format.html { redirect_to masters_coverages_path, notice: 'Coverage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Get data and configurations for visualization
  def search
    tag_list = params[:tag_list]
    @coverages = Coverage.master.tagged_with(tag_list)
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb
    
    # add_breadcrumb "master insurance", master_riders_path if @coverage.rider.insurance.is_master?

    
    if @coverage.rider.insurance 
      add_breadcrumb "Master insurance", master_riders_path if @coverage.rider.insurance.is_master?

      if @coverage.rider.insurance.book
        # normal rider
        add_breadcrumb "User", persons_path
        add_breadcrumb @coverage.rider.insurance.book.person.first_name, person_path(@coverage.rider.insurance.book.person)
        add_breadcrumb @coverage.rider.insurance.book.number, person_book_path(@coverage.rider.insurance.book.person, @coverage.rider.insurance.book)
      else
        # master rider
        if @coverage.rider.insurance.is_master?
          add_breadcrumb @coverage.rider.insurance.name, master_insurance_path(@coverage.rider.insurance) 
        end
      end
      # add_breadcrumb @coverage.rider.insurance.name, book_insurance_path(@coverage.rider.insurance.book, @coverage.rider.insurance)
      add_breadcrumb @coverage.rider.name, insurance_rider_path(@coverage.rider.insurance, @coverage.rider) if @coverage and @coverage.rider
    else
      if @coverage.rider
        # master rider
        if @coverage.rider.is_master?
          add_breadcrumb "Master Rider", master_riders_path
          add_breadcrumb @coverage.rider.name, master_rider_path(@coverage.rider)
        end
      else
        # master coverage itself
        
      end

    end
    
    #coverage
    add_breadcrumb @coverage.key, rider_coverage_path(@coverage.rider, @coverage)
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb_master
    add_breadcrumb "Master coverage", master_coverages_path
    add_breadcrumb @coverage.key, master_coverage_path(@coverage) if @coverage
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coverage
      @coverage = Coverage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coverage_params
      params.require(:coverage).permit(:key, :description, :value, :tag_list, :reference_id)
    end

    # Get metric
    def set_rider
      @rider = Rider.find(params[:rider_id])
    end
end
