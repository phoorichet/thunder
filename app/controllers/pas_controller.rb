class PasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:index, :new, :show, :edit, :create, :update, :destroy, :new_from_master, :create_from_master]
  before_action :set_pa, only: [:show, :edit, :update, :destroy]
  before_action :set_master_pa, only: [:show_master, :edit_master, :update_master, :destroy_master]
  before_action :breadcrumb, only: [:index, :show, :edit]
  before_action :breadcrumb_master, only: [:index_master, :show_master, :edit_master]

  # GET /pas
  # GET /pas.json
  def index
    page = params[:page] || 1
    @pas = @book.pas.page(page)
  end

  # GET /pas/1
  # GET /pas/1.json
  def show
  end

  # GET /pas/new
  def new
    copy_from_id = params[:uid]
    if copy_from_id != "" 
      cloned_pa = Pa.find_by_id(copy_from_id)
      if cloned_pa 
        attrs = cloned_pa.copied_attributes
        @pa = @book.pas.new(attrs)
      else
        @pa = @book.pas.new
      end
      
    else
      @pa = @book.pas.new
    end
  end

  # GET /pas/1/edit
  def edit
  end

  # POST /pas
  # POST /pas.json
  def create
    @pa = @book.pas.new(pa_params)

    respond_to do |format|
      if @pa.save
        # Deep clone coverage in the reference pa
        if pa_params[:reference_id] != ""
          reference_pa = Pa.find_by_id(pa_params[:reference_id])
          if reference_pa
            reference_pa.coverages.each { |d| @pa.coverages.create(d.copied_attributes) }
          end
        end
        format.html { redirect_to [@pa.book, @pa], notice: 'Pa was successfully created.' }
        format.json { render :show, status: :created, location: @pa }
      else
        format.html { render :new }
        format.json { render json: @pa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pas/1
  # PATCH/PUT /pas/1.json
  def update
    respond_to do |format|
      if @pa.update(pa_params)
        format.html { redirect_to [@pa.book, @pa], notice: 'Pa was successfully updated.' }
        format.json { render :show, status: :ok, location: @pa }
      else
        format.html { render :edit }
        format.json { render json: @pa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pas/1
  # DELETE /pas/1.json
  def destroy
    @pa.destroy
    respond_to do |format|
      format.html { redirect_to [@pa.book.person, @pa.book], notice: 'Pa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  # GET /pas/masters
  # GET /pas/masters.json
  def index_master
    page = params[:page] || 1
    @pas = Pa.master.page(page)
  end

  # GET /pas/1/master
  # GET /pas/1/master.json
  def show_master
  end

  # GET /pas/master_new
  def new_master
    @pa = Pa.new(pa_type: 'master')
  end

  # GET /pas/1/edit_master
  def edit_master
  end

  # POST /pas/create_master
  # POST /pas/create_master.json
  def create_master
    @pa = Pa.new(pa_params)
    @pa.pa_type = 'master'

    respond_to do |format|
      if @pa.save
        format.html { redirect_to master_pa_path(@pa), notice: 'Pa was successfully created.' }
        format.json { render :show_master, status: :created, location: @pa }
      else
        format.html { render :new_master }
        format.json { render json: @pa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pas/update_master/1
  # PATCH/PUT /pas/update_master/1.json
  def update_master
    respond_to do |format|
      if @pa.update(pa_params)
        format.html { redirect_to master_pa_path(@pa), notice: 'Pa was successfully updated.' }
        format.json { render :show_master, status: :ok, location: @pa }
      else
        format.html { render :edit_master }
        format.json { render json: @pa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pas/1/delete_master
  # DELETE /pas/1/delete_master.json
  def destroy_master
    @pa.destroy
    respond_to do |format|
      format.html { redirect_to masters_pas_path, notice: 'Pa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Get data and configurations for visualization
  def search
    tag_list = params[:tag_list]
    @pas = Pa.master.tagged_with(tag_list)
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb
    add_breadcrumb "Users", persons_path if @pa.book
    add_breadcrumb "Master book", master_pas_path if @pa.is_master?

    add_breadcrumb @pa.book.person.first_name, person_path(@pa.book.person) if @pa.book
    add_breadcrumb @pa.book.number, person_book_path(@pa.book.person, @pa.book) if @pa.book
    if @pa.is_master?
      add_breadcrumb @pa.book.number, master_book_path(@pa.book) 
    else
      add_breadcrumb @pa.book.number, book_pa_path(@pa.book, @pa)
    end
    add_breadcrumb @pa.name, book_pa_path(@pa.book, @pa) if @pa
  end

  # breadcrumb enable breadcrumb in the view
  def breadcrumb_master
    add_breadcrumb "Master Pa", master_pas_path
    add_breadcrumb @pa.name, master_pa_path(@pa) if @pa
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pa
      @pa = Pa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pa_params
      params.require(:pa).permit(:name, :description, :status, :code_name, :reference_id, :tag_list)
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_master_pa
      @pa = Pa.master.find(params[:id])
    end
end
