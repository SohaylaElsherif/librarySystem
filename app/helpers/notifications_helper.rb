module NotificationsHelper

  def set_notification
    @notification = Notification.find(params[:id])
    # Make sure the notification belongs to the current user before proceeding
    unless @notification.user == current_user || @notification.admin_user == current_admin_user
      redirect_to notifications_path, alert: 'You do not have permission to access this notification.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to notifications_path, alert: 'Notification not found.'
  end

  def notification_params
    params.require(:notification).permit(:user_id, :admin_user_id, :message)
  end
  
end
