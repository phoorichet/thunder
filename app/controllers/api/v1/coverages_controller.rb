module Api
  module V1
    class CoveragesController < ApplicationController
      # before_action :set_collection, only: [:show, :edit, :update, :destroy, :additem, :toggle_item]
      # before_action :authenticate_user!

      respond_to :json

      # Get data and configurations for visualization
      def search
        tag_list = params[:tag_list]
        results = Coverage.master.tagged_with(tag_list)
                            
        respond_with results
      end


    end # class

  end # V1
end # Api
