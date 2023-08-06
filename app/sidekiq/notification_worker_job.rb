class NotificationWorkerJob
  include Sidekiq::Job

  def perform(*args)
    notification = Notification.find_by(id: notification_id)
    return unless notification

    if notification.user
      User.Notification(notification).save
    elsif notification.admin_user
      admin_user.Notification(notification).save
    end
  end
end
