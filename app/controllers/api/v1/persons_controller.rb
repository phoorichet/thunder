module Api
  module V1
    class PersonsController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      respond_to :json
      
      before_action :authenticate_user!
      before_action :set_person, only: [:show, :edit, :update, :destroy, :create_parent]

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
            format.json { render :show, status: :created, location: @person }
          else
            format.json { render json: @person.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /persons/1
      # PATCH/PUT /persons/1.json
      def update
        respond_to do |format|
          if @person.update(person_params)
            # Update spouse
            # if @person.spouse_id != nil and @person.spouse_id != @person.spouse.id
            #   @person.spouse = Person.find(@person.spouse_id)
            # end
            
            format.json { render :show, status: :ok, location: @person }
          else
            format.json { render json: @person.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /persons/1
      # DELETE /persons/1.json
      def destroy
        @person.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      # PUT /persons/1/set_parent
      # PUT /persons/1/set_parent.json
      def set_parent
        parent = Person.find(person_params[:parent_id])
        @person.parent = parent
        respond_to do |format|
          if @person.save
            format.json { render :show, status: :ok, location: @person }
          else
            format.html { render :edit }
            format.json { render json: @person.errors, status: :unprocessable_entity }
          end
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_person
          @person = Person.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def person_params
          params.require(:person).permit(:first_name, :last_name, :gender, :date_of_birth, \
            :marital_status, :spouse_id, :income, :national_id, :passport_id, :height, :weight, :occupation, \
            :parent_id)
        end

      # Get data and configurations for visualization
      def search
        first_name = params[:first_name]
        last_name  = params[:last_name]
        results = Person.search_first_name(first_name)
                            .search_last_name(last_name)
                            
        respond_with results
      end




    end # class

  end # V1
end # Api
