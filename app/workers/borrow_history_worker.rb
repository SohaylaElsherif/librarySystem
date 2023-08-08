class BorrowHistoryWorker
  include Sidekiq::Worker


  def perform(borrow_history_id)
    borrow_history = BorrowHistory.find_by(id: borrow_history_id)
    return unless borrow_history

    user_notification_message = 'Your return date is tomorrow.'
    admin_notification_message = "#{borrow_history.user.email}'s return date for #{borrow_history.book.title} is tomorrow."

    Notification.new(user_id: borrow_history.user_id, message: user_notification_message)
    Notification.new(admin_user_id: borrow_history.admin_user_id, message: admin_notification_message)
  end
end

