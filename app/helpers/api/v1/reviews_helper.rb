module Api::V1::ReviewsHelper

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def self.for_book(book)
    where(book: book)
  end
  def create_review_user_book(user, book )
      Review.create(user: user, book: book, review_type: 'user-book', rating: 0 , comment: ' ')
    end
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
