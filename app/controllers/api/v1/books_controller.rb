module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: [:show, :update, :destroy]

      def index
        @q = Book.ransack(params[:q])

        # Dynamically handle filtering based on provided parameters
        books = if params[:q].present?
          @q.result.includes(:category_1, :category_2, :category_3, :shelf)
               .order(:position)
               .page(params[:page])
               .per(params[:per_page])
        else
          Book.includes(:category_1, :category_2, :category_3, :shelf)
              .order(:position)
              .page(params[:page])
              .per(params[:per_page])
        end

        # Dynamically handle sorting based on provided sort parameter
        if params[:q].present? && params[:q][:s].present?
          sort_param = params[:q][:s]
          books = books.joins(:reviews).reorder(sort_param)
        end

        render json: books
      end

      def show
        render json: @book
      end

      private

      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :author, :shelf_id, :category_1_id, :category_2_id, :category_3_id, :reviews, :available)
      end
    end
  end
end
