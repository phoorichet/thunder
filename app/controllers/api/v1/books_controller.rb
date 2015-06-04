module Api
  module V1
    class BooksController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      respond_to :json
      
      before_action :authenticate_user!
      before_action :set_insured_user
      before_action :set_book, only: [:show, :edit, :update, :destroy]



      # GET /books
      # GET /books.json
      def index
        page = params[:page] || 1
        @books = @insured_user.books.page(page)
      end

      # GET /books/1
      # GET /books/1.json
      def show
      end

      # GET /books/new
      def new
        @book = @insured_user.books.new
      end

      # GET /books/1/edit
      def edit
      end

      # POST /books
      # POST /books.json
      def create
        @book = @insured_user.books.new(book_params)

        respond_to do |format|
          if @book.save
            format.json { render :show, status: :created, location: api_v1_insured_user_book_url(@book.insured_user, @book) }
          else
            format.json { render json: @book.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /books/1
      # PATCH/PUT /books/1.json
      def update
        respond_to do |format|
          if @book.update(book_params)
            format.json { render :show, status: :ok, location: api_v1_insured_user_book_url(@book.insured_user, @book) }
          else
            format.json { render json: @book.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /books/1
      # DELETE /books/1.json
      def destroy
        @book.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_book
          @book = Book.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def book_params
          params.require(:book).permit(:number, :begin_at, :end_at)
        end

        # Set insured_user
        def set_insured_user
          @insured_user = InsuredUser.find(params[:insured_user_id])
        end


    end # class

  end # V1
end # Api
