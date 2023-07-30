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
  validates :borrow_date, presence: true
  validates :status, presence: true, inclusion: { in: ['pending', 'accepted', 'rejected', 'borrowed', 'late', 'done'] }
  validate :borrow_date_cannot_be_in_past


  def borrow_date_cannot_be_in_past
    if borrow_date.present? && borrow_date < Date.today
      errors.add(:borrow_date, "can't be in the past ")
    end
  end
  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "borrow_date", "borrowed_days", "created_at", "id", "return_date", "status", "updated_at", "user_id"]
  end
  after_create :schedule_notification_job

  def schedule_notification_job
    NotificationWorker.perform_in(return_date - Time.zone.now, id) if return_date > Time.zone.now
  end
end
