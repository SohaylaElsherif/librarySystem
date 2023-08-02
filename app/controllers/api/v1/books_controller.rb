module Api
  module V1
    class BooksController < ApplicationController
      respond_to :json

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
      def borrow
        if @book.available?
          # Get the borrow_date and return_date from the request params
          borrow_date = Time.zone.parse(params[:borrow_date])
          return_date = Time.zone.parse(params[:return_date])

          # Check if the return_date is valid (after borrow_date and within 30 days)
          if borrow_date.present? && return_date.present? && return_date >= borrow_date && return_date <= (borrow_date + 30.days)
            borrowing = BorrowHistory.create(user: current_user, book: @book, borrow_date: borrow_date, return_date: return_date, status: 'borrowed')
            render json: { message: 'Book borrowed successfully.' }
          else
            render json: { error: 'Invalid borrow_date or return_date. Return date should be after borrow date and within 30 days from the borrow date.' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Book is not available for borrowing.' }, status: :unprocessable_entity
        end
      end

      def return
        borrowing = BorrowHistory.find_by(user: current_user, book: @book, status: 'borrowed')
        if borrowing
          # Get the return_date from the request params
          return_date = Time.zone.parse(params[:return_date])

          # Check if the return_date is valid (after borrow_date)
          if return_date.present? && return_date >= borrowing.borrow_date
            borrowing.update(status: 'done', return_date: return_date)
            render json: { message: 'Book returned successfully.' }
          else
            render json: { error: 'Invalid return_date. Return date should be after borrow date.' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Book is not currently borrowed.' }, status: :unprocessable_entity
        end
      end

      private

      def set_book
        book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :author, :shelf_id, :category_1_id, :category_2_id, :category_3_id, :reviews, :available)
      end
    end
  end
end
