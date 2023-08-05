class NotificationMailer < ApplicationMailer
    def borrow_request_pending(user)
      @user = user
      mail(to: @user.email, subject: 'Your borrow request is pending')
    end
  
    def borrow_status_change(user, status)
      @user = user
      @status = status
      mail(to: @user.email, subject: 'Borrow status update')
    end
  
    def return_reminder(user, book)
      @user = user
      @book = book
      mail(to: @user.email, subject: 'Return Reminder')
    end
  
    def return_notification_to_admin(user, book)
      @user = user
      @book = book
      mail(to: 'admin@example.com', subject: 'Return Reminder')
    end
  end
end
  
