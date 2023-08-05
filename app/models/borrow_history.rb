# app/models/borrow_history.rb
class BorrowHistory < ApplicationRecord
  belongs_to :user
  belongs_to :book
  enum status: {
    pending: 'pending',
    accepted: 'accepted',
    rejected: 'rejected',
    borrowed: 'borrowed',
    late: 'late',
    done: 'done'
  }
  validates :user, presence: true
  validates :book, presence: true
  validates :borrow_date, :return_date, presence: true
  validates :status, presence: true, inclusion: { in: ['pending', 'accepted', 'rejected', 'borrowed', 'late', 'done'] }
  validate :borrow_date_cannot_be_in_past
  validate :check_date_range_with_accepted_or_done

  after_update :send_status_change_notification
  after_create :send_borrow_request_notification
  after_commit :send_return_reminder_notification, on: :create

  private

  def send_status_change_notification
    if saved_change_to_status? # Only send the notification if the status has been changed
      # Send notification to the user about status change
      NotificationMailer.borrow_status_change(user, status).deliver_now
    end
  end

  def send_borrow_request_notification
    # Send notification to the user that the request is pending
    NotificationMailer.borrow_request_pending(user).deliver_now
  end

  def send_return_reminder_notification
    # Calculate return_date - 1 day to send the notification one day before the return date
    return_reminder_date = return_date - 1.day
    # Send notification to the user one day before the return date
    NotificationMailer.return_reminder(user, book).deliver_later(wait_until: return_reminder_date)
    # Send notification to the admin about the return date
    NotificationMailer.return_notification_to_admin(user, book).deliver_later(wait_until: return_reminder_date)
  end


  # Custom validation method to check date range with accepted or done status
  def check_date_range_with_accepted_or_done
    overlapping_borrows = BorrowHistory.where('(borrow_date, return_date) overlaps (?, ?)', borrow_date, return_date)
                               .where(status: ['accepted', 'done'])
                               .where.not(id: id) # Exclude the current record if it's being updated
    errors.add(:base, 'Book already borrowed or accepted for the selected date range') if overlapping_borrows.exists?
  end

  def borrow_date_cannot_be_in_past
    if borrow_date.present? && borrow_date < Date.today
      errors.add(:borrow_date, "can't be in the past ")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "borrow_date", "borrowed_days", "created_at", "id", "return_date", "status", "updated_at", "user_id"]
  end
end
