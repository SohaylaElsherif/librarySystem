class PendingBorrowRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending_borrow_requests = current_user.pending_borrow_requests
    respond_to do |format|
      format.html # render index.html.erb
      format.json { render json: @pending_borrow_requests, status: :ok }
    end
  end

  def show
    @pending_borrow_request = current_user.pending_borrow_requests.find(params[:id])
    respond_to do |format|
      format.html # render show.html.erb
      format.json { render json: @pending_borrow_request, status: :ok }
    end
  end

  def create
    borrow_date = params[:borrow_date]
    return_date = params[:return_date]

    if borrow_date.nil? || return_date.nil?
      render json: { error: 'Borrow date and return date are required' }, status: :unprocessable_entity
      return
    end

    begin
      borrow_date = Date.parse(borrow_date)
      return_date = Date.parse(return_date)
    rescue ArgumentError
      render json: { error: 'Invalid date format' }, status: :unprocessable_entity
      return
    end

    # Check book availability
    book_availability = RequestAvailability.find_by(book_id: params[:book_id])
    if book_availability && ((book_availability.borrow_date..book_availability.return_date).cover?(Date.today) || book_availability.status == 'valid')
      redirect_to book_availability_path(book_availability.book)
    else
      pending_borrow_request = current_user.pending_borrow_requests.new(borrow_request_params)
      respond_to do |format|
        if pending_borrow_request.save
          format.html { redirect_to pending_borrow_request, notice: 'Pending borrow request was successfully created.' }
          format.json { render json: pending_borrow_request, status: :created }
        else
          format.html { render :new }
          format.json { render json: { errors: pending_borrow_request.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    pending_borrow_request = current_user.pending_borrow_requests.find(params[:id])
    respond_to do |format|
      if pending_borrow_request.update(borrow_request_params)
        format.html { redirect_to pending_borrow_request, notice: 'Pending borrow request was successfully updated.' }
        format.json { render json: pending_borrow_request, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { errors: pending_borrow_request.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    pending_borrow_request = current_user.pending_borrow_requests.find(params[:id])
    pending_borrow_request.destroy
    respond_to do |format|
      format.html { redirect_to pending_borrow_requests_url, notice: 'Pending borrow request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def borrow_request_params
    params.require(:pending_borrow_request).permit(:book_id, :borrow_date, :return_date)
  end
end
