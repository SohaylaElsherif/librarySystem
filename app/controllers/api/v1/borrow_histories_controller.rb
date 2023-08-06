class Api::V1::BorrowHistoriesController < ApplicationController
  include JsonWebToken
  respond_to :json

  def create
    borrow_history = current_user.borrow_histories.new(borrow_history_params)

    if borrow_history.save
      # Send custom notification using a method send_custom_notification
      send_custom_notification(borrow_history)
      render json: borrow_history, status: :created
    else
      render json: borrow_history.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: borrow_history
  end

  private

  def set_borrow_history
    borrow_history = BorrowHistory.find(params[:id])
  end

  def borrow_history_params
    params.require(:borrow_history).permit(:book_id, :borrow_date, :return_date)
  end

  def send_custom_notification(borrow_history)
    # a Notification model to store notifications
    Notification.create(
      user_id: borrow_history.user_id,
      message: "Your book request for Book ID #{borrow_history.book_id} is pending."
    )
  end
end
