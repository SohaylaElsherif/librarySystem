module Api::V1::ReviewsHelper
  extend ActiveSupport::Concern

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def build_user_book_review(params)
    review = Review.new(params)
    review.review_type = "user-book"
    review
  end

  def self.for_book(book)
    where(book: book)
  end

  def create_review_user_book(user, book)
    Review.create!(user: user, book: book, review_type: 'user-book', rating: 0, comment: ' ')
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
