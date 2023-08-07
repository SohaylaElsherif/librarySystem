module Api
  module V1
    class BooksController < ApplicationController
      respond_to :json

      def index
        @filter_by = Book.ransack(params[:filter_by])

        # Dynamically handle filtering based on provided parameters
        books = if params[:filter_by].present?
          categories = params[:filter_by][:categories_in].split(',') if params[:filter_by][:categories_in].present?

          filtered_books = @filter_by.result.includes(:categories, :shelf)

          # Filter books by multiple categories if categories parameter is provided
          filtered_books = filtered_books.joins(:categories).merge(Category.where(id: categories)) if categories.present?

          filtered_books.order(:position)
                       .page(params[:page])
                       .per(params[:per_page])
        else
          Book.includes(:categories, :shelf)
              .order(:position)
              .page(params[:page])
              .per(params[:per_page])
        end

        # Dynamically handle sorting based on provided sort parameter
        if params[:filter_by].present? && params[:filter_by][:sort_by].present?
          sort_param = params[:filter_by][:sort_by]
          books = books.joins(:reviews).reorder(sort_param)
        end

        render json: books
      end
      def show
        render json: @book
      end

      private

      def set_book
        book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :author, :shelf_id, :category_ids, :reviews, :available)
      end
    end
  end
end
