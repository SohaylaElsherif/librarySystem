class Api::V1::NotificationsController < BaseController
  include Api::V1::NotificationsHelper
  before_action :set_notification, only: [:show, :destroy]

  def index
    if current_user.is_a?(User)
      @notifications = current_user.notifications
    elsif current_user.is_a?(AdminUser)
      @notifications = current_admin_user.notifications
    end
  end

  def show
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      redirect_to @notification, notice: 'Notification was successfully created.'
    else
      render :new
    end
  end


  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: 'Notification was successfully destroyed.'
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to notifications_path, alert: 'Notification not found.'
  end

  def notification_params
    params.require(:notification).permit(:user_id, :admin_user_id, :message)
  end
end
