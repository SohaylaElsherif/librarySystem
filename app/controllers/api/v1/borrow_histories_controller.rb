class Api::V1::BorrowHistoriesController < ApplicationController
      before_action :authenticate_user!
    
      def create
        borrow_history = BorrowHistory.new(borrow_history_params)
        if borrow_history.save
          # Send notification to the user that the request is pending
          NotificationMailer.borrow_request_pending(borrow_history.user).deliver_now
          render json: borrow_history, status: :created
        else
          render json: borrow_history.errors, status: :unprocessable_entity
        end
      end
    
      def update
        borrow_history = BorrowHistory.find(params[:id])
        authorize borrow_history
    
        if borrow_history.update(borrow_history_params)
          # Send notification to the user about status change
          NotificationMailer.borrow_status_change(borrow_history.user, borrow_history.status).deliver_now
          render json: borrow_history
        else
          render json: borrow_history.errors, status: :unprocessable_entity
        end
      end

    
      private
    
      def borrow_history_params
        params.require(:borrow_history).permit(:user_id, :book_id, :borrow_date, :return_date, :borrowed_days, :status)
      end
    end
    