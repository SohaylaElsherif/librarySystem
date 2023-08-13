module Library

    class BooksController < BaseController
      include BooksHelper
    before_action :set_book, only: [:show, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    #before_action :authorize_admin, only: [:create, :update, :destroy]
    def index
      books = filter_and_sort_books(params)
      render json: books, each_serializer: BookSerializer
    end

    def show
      render json: @book, serializer: BookSerializer
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: [{ title: I18n.t('errors.book_not_found'), detail: e.message }] }, status: :not_found
    end

#    def create
#      book = Book.new(book_params)
#      if book.save
#        render json: book, serializer: BookSerializer, status: :created
#      else
#        render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
#      end
#    end

#    def update
#      if @book.update(book_params)
#        render json: @book, serializer: BookSerializer
#      else
#        render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
#      end
#    end

#    def destroy
#      @book.destroy
#      head :no_content
#    end

   
  end
end