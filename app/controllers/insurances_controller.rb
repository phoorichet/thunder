class InsurancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:index, :new, :show, :edit, :update, :destroy, :create, :new_from_master, :new_main]
  before_action :set_insurance, only: [:show, :edit, :update, :destroy]
  before_action :set_master_insurance, only: [:show_master, :edit_master, :update_master, :destroy_master]
  before_action :breadcrumb, only: [:index, :show, :edit]
  before_action :breadcrumb_master, only: [:index_master, :show_master, :edit_master]

  # GET /insurances
  # GET /insurances.json
  def index
    page = params[:page] || 1
    @insurances = @book.insurances.page(page)
  end

  # GET /insurances/1
  # GET /insurances/1.json
  def show
    
  end

  # GET /insurances/new
  def new
    copy_from_id = params[:uid]
    if copy_from_id != nil 
      cloned_insurance = Insurance.find_by_id(copy_from_id)
      if cloned_insurance 
        attrs = cloned_insurance.copied_attributes
        @insurance = @book.insurances.new(attrs)
      else
        @insurance = @book.insurances.new
      end
      
    else
      @insurance = @book.insurances.new
    end

    @insurance.insurance_type = "rider"
  end

  # GET /insurances/new_main
  def new_main
    copy_from_id = params[:uid]
    if copy_from_id != nil 
      cloned_insurance = Insurance.find_by_id(copy_from_id)
      if cloned_insurance 
        attrs = cloned_insurance.copied_attributes
        @insurance = @book.insurances.new(attrs)
      else
        @insurance = @book.insurances.new
      end
      
    else
      @insurance = @book.insurances.new
    end
    
    @insurance.insurance_type = "main"
  end

  # GET /insurances/new_from_master
  def new_from_master
    @insurance = @book.insurances.new
  end

  # GET /insurances/1/edit
  def edit
  end

  # POST /insurances
  # POST /insurances.json
  def create
    @insurance = @book.insurances.new(insurance_params)
    if insurance_params[:reference_id] != ""
        @reference_insurance = Insurance.find_by_id(insurance_params[:reference_id]) 
    end

    respond_to do |format|
      if @insurance.save
        # copy dividens, returns, protections, surrenders
        if @reference_insurance != nil
          # dividends
          @reference_insurance.dividends.each { |d| @insurance.dividends.create(d.copied_attributes) }
          # seturns
          @reference_insurance.returns.each { |d| @insurance.returns.create(d.copied_attributes) }
          # protections
          @reference_insurance.protections.each { |d| @insurance.protections.create(d.copied_attributes) }
          # surrenders
          @reference_insurance.surrenders.each { |d| @insurance.surrenders.create(d.copied_attributes) }
        end

        format.html { redirect_to [@insurance.book, @insurance], notice: 'Insurance was successfully created.' }
        format.json { render :show, status: :created, location: @insurance }
      else
        format.html { render :new }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurances/1
  # PATCH/PUT /insurances/1.json
  def update
    respond_to do |format|
      if @insurance.update(insurance_params)
        # if this insurance is main_insurance and there is existing main insurance, it will
        # change the existing insurance to normal insurance
        if @insurance.is_main?
          @book.main_insurances.where("id != ?", @insurance.id).each do |insurance|
            insurance.is_main = false
            insurance.save
          end
        end

        format.html { redirect_to [@insurance.book, @insurance], notice: 'Insurance was successfully updated.' }
        format.json { render :show, status: :ok, location: @insurance }
      else
        format.html { render :edit }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurances/1
  # DELETE /insurances/1.json
  def destroy
    @insurance.destroy
    respond_to do |format|
      format.html { redirect_to [@insurance.book.person, @insurance.book], notice: 'Insurance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # GET /insurances/masters
  # GET /insurances/masters.json
  def index_master
    page = params[:page] || 1
    @insurances = Insurance.master.page(page)
  end

  # GET /insurances/1/master
  # GET /insurances/1/master.json
  def show_master
  end

  # GET /insurances/master_new
  def new_master
    @insurance = Insurance.new(insurance_type: 'master')
  end

  # GET /insurances/1/edit_master
  def edit_master
  end

  # POST /insurances/create_master
  # POST /insurances/create_master.json
  def create_master
    @insurance = Insurance.new(insurance_params)
    @insurance.insurance_type = 'master'

    respond_to do |format|
      if @insurance.save
        format.html { redirect_to master_insurance_path(@insurance), notice: 'Insurance was successfully created.' }
        format.json { render :show_master, status: :created, location: @insurance }
      else
        format.html { render :new_master }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurances/update_master/1
  # PATCH/PUT /rideinsurancesrs/update_master/1.json
  def update_master
    respond_to do |format|
      if @insurance.update(insurance_params)
        format.html { redirect_to master_insurance_path(@insurance), notice: 'Insurance was successfully updated.' }
        format.json { render :show_master, status: :ok, location: @insurance }
      else
        format.html { render :edit_master }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurances/1/delete_master
  # DELETE /insurances/1/delete_master.json
  def destroy_master
    @insurance.destroy
    respond_to do |format|
      format.html { redirect_to masters_insurances_path, notice: 'insurance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Get data and configurations for visualization
  def search
    tag_list = params[:tag_list]
    @insurances = Insurance.master.tagged_with(tag_list)
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb
    add_breadcrumb "Users", persons_path
    add_breadcrumb @insurance.book.person.first_name, person_path(@insurance.book.person) if @insurance.book.person
    add_breadcrumb @insurance.book.number, person_book_path(@insurance.book.person, @insurance.book) if @insurance.book
    add_breadcrumb @insurance.name, book_insurance_path(@insurance.book, @insurance) if @insurance
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb_master
    add_breadcrumb "Master insurance", master_insurances_path
    add_breadcrumb @insurance.name, master_insurance_path(@insurance) if @insurance
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance
      @insurance = Insurance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insurance_params
      params.require(:insurance).permit(:name, :insurance_type, 
        :book_id, :master_insurance_id, :reference_id, :tag_list, :is_main, :minimum_age,
        :maximum_age, :consider_year, :consider_gender, :have_surrender, 
        :have_dividend, :paid_period_length, :protection_length, :group,
        :company, :insurance_type, :amount, :premium, :maximum_cover_age)
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_master_insurance
      @insurance = Insurance.master.find(params[:id])
    end
end
