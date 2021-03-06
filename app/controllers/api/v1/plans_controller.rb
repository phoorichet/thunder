module Api
  module V1
    class PlansController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      respond_to :json
      
      before_action :authenticate_user!
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
        copy_from_id = params[:uid]
        if copy_from_id != nil 
          cloned_plan = Plan.find_by_id(copy_from_id)
          if cloned_plan 
            attrs = cloned_plan.copied_attributes
            @plan = @book.plans.new(attrs)
          else
            @plan = @book.plans.new
          end
          
        else
          @plan = @book.plans.new
        end
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
        if plan_params[:reference_id] != ""
            @reference_plan = Plan.find_by_id(plan_params[:reference_id]) 
        end

        respond_to do |format|
          if @plan.save
            # copy all the riders, and coverages to the new plan
            if @reference_plan != nil
              # copy riders
              @reference_plan.riders.each do |rider|
                new_rider = @plan.riders.new(rider.copied_attributes)
                new_rider.save

                # copy coverage
                rider.coverages.each do |coverage|
                  new_coverage = new_rider.coverages.new(coverage.copied_attributes)
                  new_coverage.save
                end
              end
            end

            format.json { render :show, status: :created, location: api_v1_book_plan_url(@plan.book, @plan) }
          else
            format.json { render json: @plan.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /plans/1
      # PATCH/PUT /plans/1.json
      def update
        respond_to do |format|
          if @plan.update(plan_params)
            format.json { render :show, status: :ok, location: api_v1_book_plan_url(@plan.book, @plan)  }
          else
            format.json { render json: @plan.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /plans/1
      # DELETE /plans/1.json
      def destroy
        @plan.destroy
        respond_to do |format|
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
            format.json { render :show, status: :created, location: api_v1_master_plan_url(@plan)  }
          else
            format.json { render json: @plan.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /plans/update_master/1
      # PATCH/PUT /rideplansrs/update_master/1.json
      def update_master
        respond_to do |format|
          if @plan.update(plan_params)
            format.json { render :show, status: :ok, location: api_v1_master_plan_url(@plan) }
          else
            format.json { render json: @plan.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /plans/1/delete_master
      # DELETE /plans/1/delete_master.json
      def destroy_master
        @plan.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      # Get data and configurations for visualization
      def search
        tag_list = params[:tag_list]
        @plans = Plan.master.tagged_with(tag_list)
      end
      
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_plan
          @plan = Plan.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def plan_params
          params.require(:plan).permit(:name, :plan_type, :begin_at, :end_at, :book_id, :master_plan_id, :reference_id, :tag_list)
        end

        def set_book
          @book = Book.find(params[:book_id])
        end

        def set_master_plan
          @plan = Plan.master.find(params[:id])
        end


    end # class

  end # V1
end # Api
