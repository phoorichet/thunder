module Api
  module V1
    class CoveragesController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      respond_to :json
      before_action :authenticate_user!
      before_action :set_rider, only: [:index, :new, :show, :edit, :create, :update, :destroy]
      before_action :set_coverage, only: [:show, :edit, :update, :destroy, 
                                      :show_master, :edit_master, :update_master, :destroy_master]

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
            format.json { render :show, status: :created, location: api_v1_rider_coverage_url(@coverage.rider, @coverage) }
          else
            format.json { render json: @coverage.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /coverages/1
      # PATCH/PUT /coverages/1.json
      def update
        respond_to do |format|
          if @coverage.update(coverage_params)
            format.json { render :show, status: :ok, location: api_v1_rider_coverage_url(@coverage.rider, @coverage) }
          else
            format.json { render json: @coverage.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /coverages/1
      # DELETE /coverages/1.json
      def destroy
        @coverage.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      def redirect_after_destroy(rider)
        if rider.is_master?
          master_rider_path(rider)
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
            format.json { render :show, status: :created, location: api_v1_master_coverage_url(@coverage) }
          else
            format.json { render json: @coverage.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /coverages/1
      # PATCH/PUT /coverages/1.json
      def update_master
        respond_to do |format|
          if @coverage.update(coverage_params)
            format.json { render :show, status: :ok, location: api_v1_master_coverage_url(@coverage) }
          else
            format.json { render json: @coverage.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /coverages/1
      # DELETE /coverages/1.json
      def destroy_master
        @coverage.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      # Get data and configurations for visualization
      def search
        tag_list = params[:tag_list]
        @coverages = Coverage.master.tagged_with(tag_list)
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_coverage
          @coverage = Coverage.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def coverage_params
          params.require(:coverage).permit(:name, :description, :coverage_amount, :category, 
            :rider_id, :rider_id, :premium_amount, :premium_unit, :coverage_unit, 
            :coverage_end_at, :tag_list, :reference_id)
        end

        # Get metric
        def set_rider
          @rider = Rider.find(params[:rider_id])
        end


    end # class

  end # V1
end # Api
