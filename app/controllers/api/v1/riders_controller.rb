module Api
  module V1
    class RidersController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      respond_to :json

      before_action :authenticate_user!
      before_action :set_insurance, only: [:index, :new, :show, :edit, :create, :update, :destroy, :new_from_master, :create_from_master]
      before_action :set_rider, only: [:show, :edit, :update, :destroy]
      before_action :set_master_rider, only: [:show_master, :edit_master, :update_master, :destroy_master]

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
            format.json { render :show, status: :created, location: api_v1_insurance_rider_url(@rider.insurance, @rider) }
          else
            format.json { render json: @rider.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /riders/1
      # PATCH/PUT /riders/1.json
      def update
        respond_to do |format|
          if @rider.update(rider_params)
            format.json { render :show, status: :ok, location: api_v1_insurance_rider_url(@rider.insurance, @rider) }
          else
            format.json { render json: @rider.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /riders/1
      # DELETE /riders/1.json
      def destroy
        @rider.destroy
        respond_to do |format|
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
            format.json { render :show, status: :created, location: api_v1_master_rider_url(@rider) }
          else
            format.json { render json: @rider.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /riders/update_master/1
      # PATCH/PUT /riders/update_master/1.json
      def update_master
        respond_to do |format|
          if @rider.update(rider_params)
            format.json { render :show, status: :ok, location: api_v1_master_rider_url(@rider) }
          else
            format.json { render json: @rider.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /riders/1/delete_master
      # DELETE /riders/1/delete_master.json
      def destroy_master
        @rider.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      # Get data and configurations for visualization
      def search
        tag_list = params[:tag_list]
        @riders = Rider.master.tagged_with(tag_list)
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

    end # class

  end # V1
end # Api
