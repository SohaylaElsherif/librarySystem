class Api::V1::BorrowHistoriesController < ApplicationController
  include JsonWebToken
  include Api::V1::BorrowHistoriesHelper
  respond_to :json
  before_action :authenticate_user!

  def index
    @borrow_histories = current_user.borrow_histories
    respond_to do |format|
      format.html # render index.html.erb
      format.json { render json: @borrow_histories, status: :ok }
    end
  end

  def create
    borrow_history = BorrowHistory.new(borrow_history_params.merge(user_id: current_user.id, status: :pending))
    respond_to do |format|
      begin
        borrow_history.save!
        # send_custom_notification(borrow_history)
        format.json { render json: borrow_history, status: :created }
      rescue ActiveRecord::RecordInvalid => e
        format.json { render json: { errors: t('errors.record_invalid', errors: e.record.errors.full_messages) }, status: :unprocessable_entity }
      rescue => e
        format.json { render json: { errors: [t('errors.unprocessable_entity', errors: e.message)] }, status: :unprocessable_entity }
      end
    end
  end

  def show
    begin
      borrow_history = current_user.borrow_histories.find(params[:id])
      respond_to do |format|
        format.html # render show.html.erb
        format.json { render json: borrow_history, status: :ok }
      end
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render json: { errors: [t('errors.not_found')] }, status: :not_found }
      end
    rescue => e
      respond_to do |format|
        format.json { render json: { errors: [t('errors.unprocessable_entity', errors: e.message)] }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      borrow_history = current_user.borrow_histories.find(params[:id])
      borrow_history.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render json: { errors: [t('errors.not_found')] }, status: :not_found }
      end
    rescue => e
      respond_to do |format|
        format.json { render json: { errors: [t('errors.unprocessable_entity', errors: e.message)] }, status: :unprocessable_entity }
      end
    end
  end

end
