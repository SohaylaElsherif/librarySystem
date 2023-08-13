class Api::V1::ReviewsController < BaseController
  include Api::V1::ReviewsHelper

  before_action :set_review, only: [:update]

  def create
    review = build_user_book_review(review_params)

    if review.save
      render json: review, status: :created
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      render json: @review, status: :ok
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    user_reviews = current_user.reviews.where(review_type: "user-book")
    render json: user_reviews, status: :ok
  end
end
