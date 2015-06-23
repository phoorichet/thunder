module Api
  module V1
    class SurrendersController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      respond_to :json

      before_action :set_surrender, only: [:show, :edit, :update, :destroy]
      before_action :set_insurance

      # GET /surrenders
      # GET /surrenders.json
      def index
        @surrenders = @insurance.surrenders.all
      end

      # GET /surrenders/1
      # GET /surrenders/1.json
      def show
      end

      # GET /surrenders/new
      def new
        @surrender = @insurance.surrenders.new
      end

      # GET /surrenders/1/edit
      def edit
      end

      # POST /surrenders
      # POST /surrenders.json
      def create
        @surrender = @insurance.surrenders.new(surrender_params)

        respond_to do |format|
          if @surrender.save
            format.html { redirect_to [@surrender.insurance, @insurance], notice: 'Surrender was successfully created.' }
            format.json { render :show, status: :created, location: [@surrender.insurance, @surrender] }
          else
            format.html { render :new }
            format.json { render json: @surrender.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /surrenders/1
      # PATCH/PUT /surrenders/1.json
      def update
        respond_to do |format|
          if @surrender.update(surrender_params)
            format.html { redirect_to [@surrender.insurance, @insurance], notice: 'Surrender was successfully updated.' }
            format.json { render :show, status: :ok, location: [@surrender.insurance, @surrender] }
          else
            format.html { render :edit }
            format.json { render json: @surrender.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /surrenders/1
      # DELETE /surrenders/1.json
      def destroy
        @surrender.destroy
        respond_to do |format|
          format.html { redirect_to book_insurance_url(@surrender.insurance.book, @surrender.insurance), notice: 'Surrender was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_surrender
          @surrender = Surrender.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def surrender_params
          params.require(:surrender).permit(:surrender_type, :year, :assured_age, :cv, :rpu, :ecv, :eti, :eti_year, :eti_day, :etipe)
        end

        def set_insurance
          @insurance = Insurance.find(params[:insurance_id])
        end
    end

  end
end
