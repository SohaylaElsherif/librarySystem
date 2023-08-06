class BorrowHistory < ApplicationRecord
  belongs_to :user
  belongs_to :book
  enum status: {
    pending: 'pending',
    accepted: 'accepted',
    rejected: 'rejected',
    borrowed: 'borrowed',
    done: 'done'
  }
  validates :user, presence: true
  validates :book, presence: true
  validates :borrow_date, presence: true
  validates :status, inclusion: { in: ['pending', 'accepted', 'rejected', 'borrowed', 'done'] }
  validate :borrow_date_cannot_be_in_past
  validate :check_date_range_with_accepted_or_done


  # Custom validation method to check date range with accepted or done status
  def check_date_range_with_accepted_or_done
    overlapping_borrows = BorrowHistory.where('(borrow_date, return_date) overlaps (?, ?)', borrow_date, return_date)
                               .where(status: ['accepted', 'done'])
                               .where.not(id: id) 
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

  after_save :schedule_notification_job

  def schedule_notification_job
    time_difference = (return_date - Time.zone.now).to_i
    delay = time_difference > 0 ? time_difference : 0
  
    NotificationWorkerJob.perform_in(delay, id)
    end
end
