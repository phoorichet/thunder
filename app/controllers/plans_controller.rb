class PlansController < ApplicationController
  before_action :set_book, only: [:index, :new, :show, :edit, :update, :destroy, :create, :new_from_master]
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :set_master_plan, only: [:show_master, :edit_master, :update_master, :destroy_master]

  # GET /plans
  # GET /plans.json
  def index
    page = params[:page] || 1
    @plans = @book.plans.page(page)
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = @book.plans.new
  end

  # GET /plans/new_from_master
  def new_from_master
    @plan = @book.plans.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = @book.plans.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to [@plan.book, @plan], notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to [@plan.book, @plan], notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to [@plan.book.insured_user, @plan.book], notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # GET /plans/masters
  # GET /plans/masters.json
  def index_master
    page = params[:page] || 1
    @plans = Plan.master.page(page)
  end

  # GET /plans/1/master
  # GET /plans/1/master.json
  def show_master
  end

  # GET /plans/master_new
  def new_master
    @plan = Plan.new(plan_type: 'master')
  end

  # GET /plans/1/edit_master
  def edit_master
  end

  # POST /plans/create_master
  # POST /plans/create_master.json
  def create_master
    @plan = Plan.new(plan_params)
    @plan.plan_type = 'master'

    respond_to do |format|
      if @plan.save
        format.html { redirect_to master_plan_path(@plan), notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/update_master/1
  # PATCH/PUT /rideplansrs/update_master/1.json
  def update_master
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to master_plan_path(@plan), notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1/delete_master
  # DELETE /plans/1/delete_master.json
  def destroy_master
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to masters_plans_path, notice: 'plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:name, :plan_type, :begin_at, :end_at, :book_id, :master_plan_id, :reference_id)
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_master_plan
      @plan = Plan.master.find(params[:id])
    end
end
