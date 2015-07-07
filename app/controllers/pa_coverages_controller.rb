class PaCoveragesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pa, only: [:index, :new, :show, :edit, :create, :update, :destroy]
  before_action :set_pa_coverage, only: [:show, :edit, :update, :destroy, 
                                      :show_master, :edit_master, :update_master, :destroy_master]
  before_action :breadcrumb, only: [:index, :show, :edit]
  before_action :breadcrumb_master, only: [:index_master, :show_master, :edit_master]


  # GET /pa_coverages
  # GET /pa_coverages.json
  def index
    page = params[:page] || 1
    @pa_coverages = @pa.pa_coverages.page(page)
  end

  # GET /pa_coverages/1
  # GET /pa_coverages/1.json
  def show
  end

  # GET /pa_coverages/new
  def new
    copy_from_id = params[:uid]
    if copy_from_id != ""
      cloned_pa_coverage = PaCoverage.find_by_id(copy_from_id)
      if cloned_pa_coverage 
        attrs = cloned_pa_coverage.copied_attributes
        @pa_coverage = @pa.pa_coverages.new(attrs)
      else
        @pa_coverage = @pa.pa_coverages.new
      end
      
    else
      @pa_coverage = @pa.pa_coverages.new
    end
    
  end

  # GET /pa_coverages/1/edit
  def edit
  end

  # POST /pa_coverages
  # POST /pa_coverages.json
  def create
    @pa_coverage = @pa.pa_coverages.new(pa_coverage_params)

    respond_to do |format|
      if @pa_coverage.save
        format.html { redirect_to [@pa_coverage.pa, @pa_coverage], notice: 'PaCoverage was successfully created.' }
        format.json { render :show, status: :created, location: @pa_coverage }
      else
        format.html { render :new }
        format.json { render json: @pa_coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pa_coverages/1
  # PATCH/PUT /pa_coverages/1.json
  def update
    respond_to do |format|
      if @pa_coverage.update(pa_coverage_params)
        format.html { redirect_to [@pa_coverage.pa, @pa_coverage], notice: 'PaCoverage was successfully updated.' }
        format.json { render :show, status: :ok, location: @pa_coverage }
      else
        format.html { render :edit }
        format.json { render json: @pa_coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pa_coverages/1
  # DELETE /pa_coverages/1.json
  def destroy
    @pa_coverage.destroy
    respond_to do |format|

      format.html { redirect_to redirect_after_destroy(@pa_coverage.pa), notice: 'PaCoverage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect_after_destroy(pa)
    if pa.is_master?
      master_pa_path(pa)
    elsif pa.book
      book_pa_path(pa.book, pa)
    else
      pa_path(pa)
    end

  end


  # GET /pa_coverages/master
  # GET /pa_coverages/master.json
  def index_master
    page = params[:page] || 1
    @pa_coverages = PaCoverage.master.page(page)
  end

  # GET /pa_coverages/1/master
  # GET /pa_coverages/1/master.json
  def show_master
  end

  # GET /pa_coverages/new_master
  def new_master
    @pa_coverage = PaCoverage.new
    @pa_coverage.coverage_type = 'master'
  end

  # GET /pa_coverages/1/edit_master
  def edit_master
  end

  # POST /pa_coverages/master
  # POST /pa_coverages/master.json
  def create_master
    @pa_coverage = PaCoverage.new(pa_coverage_params)
    @pa_coverage.coverage_type = 'master'

    respond_to do |format|
      if @pa_coverage.save
        format.html { redirect_to master_pa_coverage_path(@pa_coverage), notice: 'PaCoverage was successfully created.' }
        format.json { render :show_master, status: :created, location: @pa_coverage }
      else
        format.html { render :new_master }
        format.json { render json: @pa_coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pa_coverages/1
  # PATCH/PUT /pa_coverages/1.json
  def update_master
    respond_to do |format|
      if @pa_coverage.update(pa_coverage_params)
        format.html { redirect_to master_pa_coverage_path(@pa_coverage), notice: 'PaCoverage was successfully updated.' }
        format.json { render :show_master, status: :ok, location: @pa_coverage }
      else
        format.html { render :edit_master }
        format.json { render json: @pa_coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pa_coverages/1
  # DELETE /pa_coverages/1.json
  def destroy_master
    @pa_coverage.destroy
    respond_to do |format|
      format.html { redirect_to masters_pa_coverages_path, notice: 'PaCoverage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Get data and configurations for visualization
  def search
    tag_list = params[:tag_list]
    @pa_coverages = PaCoverage.master.tagged_with(tag_list)
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb
    if @pa_coverage.pa
      # master pa
      if @pa_coverage.pa.is_master?
        add_breadcrumb "Master Pa", master_pas_path
        add_breadcrumb @pa_coverage.pa.name, master_pa_path(@pa_coverage.pa)
      else
      # normal pa
        add_breadcrumb "User", persons_path
        add_breadcrumb @pa_coverage.pa.book.person.first_name, person_path(@pa_coverage.pa.book.person)
        add_breadcrumb @pa_coverage.pa.name, book_pa_path(@pa_coverage.pa.book, @pa_coverage.pa) if @pa_coverage and @pa_coverage.pa
      end
    else
      # Master pa_coverages
      add_breadcrumb "Master PaCoverages", master_pa_coverages_path
    end
    
    #pa_coverage
    add_breadcrumb @pa_coverage.key, pa_pa_coverage_path(@pa_coverage.pa, @pa_coverage)
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb_master
    add_breadcrumb "Master pa_coverage", master_pa_coverages_path
    add_breadcrumb @pa_coverage.key, master_pa_coverage_path(@pa_coverage) if @pa_coverage
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pa_coverage
      @pa_coverage = PaCoverage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pa_coverage_params
      params.require(:pa_coverage).permit(:key, :description, :value, :tag_list, :reference_id)
    end

    # Get metric
    def set_pa
      @pa = Pa.find(params[:pa_id])
    end
end
