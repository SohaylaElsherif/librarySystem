class Api::V1::BorrowHistoriesController < ApplicationController
    include JsonWebToken
    #before_action :authenticate_user!
    def index 
      borrow_history = current_user.pending_borrow_requests
      respond_to do |format|
        format.html # render index.html.erb
        format.json { render json: borrow_history, status: :ok }
      end
    end

    def create
      @borrow_history = current_user.borrow_histories.new(borrow_history_params)
      respond_to do |format|
        if borrow_history.save
          send_custom_notification(@borrow_history)
          format.html #{ redirect_to , notice: 'Pending borrow request was successfully created.' }
          format.json { render json: borrow_history, status: :created }
        else
          format.html { render :new }
          format.json { render json: { errors: borrow_history.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end
  
    def show
      borrow_history = current_user.borrow_history.find(params[:id])
      respond_to do |format|
        format.html # render show.html.erb
        format.json { render json: borrow_history, status: :ok }
      end
      end
  
    private
  
    def set_borrow_history
      @borrow_history = BorrowHistory.find(params[:id])
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
  