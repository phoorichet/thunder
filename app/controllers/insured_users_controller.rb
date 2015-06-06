class InsuredUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_insured_user, only: [:show, :edit, :update, :destroy, :create_parent]
  before_action :breadcrumb, only: [:show, :edit, :index]


  # GET /insured_users
  # GET /insured_users.json
  def index
    page = params[:page] || 1
    @insured_users = InsuredUser.page(page).order_by_fist_name
  end

  # GET /insured_users/1
  # GET /insured_users/1.json
  def show
  end

  # GET /insured_users/new
  def new
    @insured_user = InsuredUser.new
  end

  # GET /insured_users/1/edit
  def edit
  end

  # POST /insured_users
  # POST /insured_users.json
  def create
    @insured_user = InsuredUser.new(insured_user_params)
    respond_to do |format|
      if @insured_user.save
        format.html { redirect_to @insured_user, notice: 'Insured user was successfully created.' }
        format.json { render :show, status: :created, location: @insured_user }
      else
        format.html { render :new }
        format.json { render json: @insured_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insured_users/1
  # PATCH/PUT /insured_users/1.json
  def update
    respond_to do |format|
      if @insured_user.update(insured_user_params)
        # Update spouse
        # if @insured_user.spouse_id != nil and @insured_user.spouse_id != @insured_user.spouse.id
        #   @insured_user.spouse = InsuredUser.find(@insured_user.spouse_id)
        # end
        
        format.html { redirect_to @insured_user, notice: 'Insured user was successfully updated.' }
        format.json { render :show, status: :ok, location: @insured_user }
      else
        format.html { render :edit }
        format.json { render json: @insured_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insured_users/1
  # DELETE /insured_users/1.json
  def destroy
    @insured_user.destroy
    respond_to do |format|
      format.html { redirect_to insured_users_url, notice: 'Insured user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /insured_users/1/set_parent
  # PUT /insured_users/1/set_parent.json
  def set_parent
    parent = InsuredUser.find(insured_user_params[:parent_id])
    @insured_user.parent = parent
    respond_to do |format|
      if @insured_user.save
        format.html { redirect_to @insured_user, notice: 'Insured user was successfully updated.' }
        format.json { render :show, status: :ok, location: @insured_user }
      else
        format.html { render :edit }
        format.json { render json: @insured_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def breadcrumb
    add_breadcrumb "insured_users", insured_users_path
    add_breadcrumb @insured_user.first_name, insured_user_path(@insured_user) if @insured_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insured_user
      @insured_user = InsuredUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insured_user_params
      params.require(:insured_user).permit(:first_name, :last_name, :gender, :date_of_birth, \
        :marital_status, :spouse_id, :income, :national_id, :passport_id, :height, :weight, :occupation, \
        :parent_id)
    end
end
