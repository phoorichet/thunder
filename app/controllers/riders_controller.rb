class RidersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:index, :new, :show, :edit, :create, :update, :destroy, :new_from_master, :create_from_master]
  before_action :set_rider, only: [:show, :edit, :update, :destroy]
  before_action :set_master_rider, only: [:show_master, :edit_master, :update_master, :destroy_master]
  before_action :breadcrumb, only: [:index, :show, :edit]
  before_action :breadcrumb_master, only: [:index_master, :show_master, :edit_master]

  # GET /riders
  # GET /riders.json
  def index
    page = params[:page] || 1
    @riders = @book.riders.page(page)
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
        @rider = @book.riders.new(attrs)
      else
        @rider = @book.riders.new
      end
      
    else
      @rider = @book.riders.new
    end
  end

  # GET /riders/1/edit
  def edit
  end

  # POST /riders
  # POST /riders.json
  def create
    @rider = @book.riders.new(rider_params)

    respond_to do |format|
      if @rider.save
        # Deep clone coverage in the reference rider
        if rider_params[:reference_id] != ""
          reference_rider = Rider.find_by_id(rider_params[:reference_id])
          if reference_rider
            reference_rider.coverages.each { |d| @rider.coverages.create(d.copied_attributes) }
          end
        end
        format.html { redirect_to [@rider.book, @rider], notice: 'Rider was successfully created.' }
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
        format.html { redirect_to [@rider.book, @rider], notice: 'Rider was successfully updated.' }
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
      format.html { redirect_to [@rider.book.person, @rider.book], notice: 'Rider was successfully destroyed.' }
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
    add_breadcrumb "Users", persons_path if @rider.book
    add_breadcrumb "Master book", master_riders_path if @rider.is_master?

    add_breadcrumb @rider.book.person.first_name, person_path(@rider.book.person) if @rider.book
    add_breadcrumb @rider.book.number, person_book_path(@rider.book.person, @rider.book) if @rider.book
    if @rider.is_master?
      add_breadcrumb @rider.book.number, master_book_path(@rider.book) 
    else
      add_breadcrumb @rider.book.number, book_rider_path(@rider.book, @rider)
    end
    add_breadcrumb @rider.name, book_rider_path(@rider.book, @rider) if @rider
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
      params.require(:rider).permit(:name, :description, :status, :code_name, :reference_id, :tag_list, :premium, :amount)
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_master_rider
      @rider = Rider.master.find(params[:id])
    end
end
