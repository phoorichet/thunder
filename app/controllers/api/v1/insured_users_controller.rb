module Api
  module V1
    class InsuredUsersController < ApplicationController
      # before_action :set_collection, only: [:show, :edit, :update, :destroy, :additem, :toggle_item]
      # before_action :authenticate_user!

      respond_to :json

      # Get data and configurations for visualization
      def search
        first_name = params[:first_name]
        last_name  = params[:last_name]
        results = InsuredUser.search_first_name(first_name)
                            .search_last_name(last_name)
                            
        respond_with results
      end




    end # class

  end # V1
end # Api
