class PendingBorrowRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    pending_borrow_requests = current_user.pending_borrow_requests
    render json: pending_borrow_requests, status: :ok
  end

  def show
    pending_borrow_request = current_user.pending_borrow_requests.find(params[:id])
  end

#  def create
#    pending_borrow_request = current_user.pending_borrow_requests.new(
#      user: current_user,
#      book: book,
#      borrow_date: borrow_date,
#      return_date: return_date,
# status: 'pending')
#    if pending_borrow_request.save
#      redirect_to pending_borrow_request, notice: 'Pending borrow request was successfully created.'
#   else
#    render :new
#    end
#  end

  def update
    pending_borrow_request = current_user.pending_borrow_requests.find(params[:id])
    if pending_borrow_request.update(borrow_request_params)
      redirect_to pending_borrow_request, notice: 'Pending borrow request was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    pending_borrow_request = current_user.pending_borrow_requests.find(params[:id])
    pending_borrow_request.destroy
    redirect_to pending_borrow_requests_url, notice: 'Pending borrow request was successfully destroyed.'
  end

  private

  def borrow_request_params
    params.require(:pending_borrow_request).permit(:book_id, :borrow_date, :return_date)
  end
end
