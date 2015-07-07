class PersonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: [:show, :edit, :update, :destroy, :create_parent]
  before_action :breadcrumb, only: [:show, :edit, :index]

  # GET /persons
  # GET /persons.json
  def index
    page = params[:page] || 1
    @persons = Person.page(page).order_by_fist_name
  end

  # GET /persons/1
  # GET /persons/1.json
  def show
  end

  # GET /persons/new
  def new
    @person = Person.new
  end

  # GET /persons/1/edit
  def edit
  end

  # POST /persons
  # POST /persons.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /persons/1
  # PATCH/PUT /persons/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /persons/1
  # DELETE /persons/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to persons_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /person/1/set_parent
  # PUT /person/1/set_parent.json
  def set_parent
    parent = Person.find(person_params[:parent_id])
    @person.parent = parent
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Insured user was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # Get data and configurations for visualization
  def search
    first_name = params[:first_name]
    last_name  = params[:last_name]

    @persons = Person.search_first_name(first_name).search_last_name(last_name)
  end

  def new_relation

  end

   def breadcrumb
    add_breadcrumb "Person", persons_path
    add_breadcrumb @person.first_name, person_path(@person) if @person
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :gender, :date_of_birth, \
        :marital_status, :spouse_id, :income, :national_id, :passport_id, :height, 
        :weight, :occupation, :person_type, :is_smoking, :parent_id)
    end
end
