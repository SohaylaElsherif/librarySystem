class BorrowHistory < ApplicationRecord
  include Api::V1::BorrowHistoriesHelper

  belongs_to :user
  belongs_to :book
  has_one :approved_by, class_name: :AdminUser , foreign_key: "admin_user_id"
  enum status: {
    pending: 0,
    accepted: 1,
    rejected: 2,
    borrowed: 3,
    done: 4
  }
  validates_presence_of :status
  validates :user, presence: true
  validates :book, presence: true
  validates :borrow_date, presence: true
  validate :borrow_date_cannot_be_in_past
  before_create :check_date_range_with_accepted_or_done

  after_commit :schedule_status_change_and_notifications, on: :update, if: :saved_change_to_status?

  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "borrow_date","approved_by", "admin_user_id","borrowed_days","created_at", "id", "return_date", "status", "updated_at", "user_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["book", "user" ,"approved_by" ]
  end

  def schedule_status_change_and_notifications
    if status == 'accepted' && borrow_date == Date.today
      update(status: 'borrowed')
      Book.find(self.book_id).update(available: false)
      time_difference = (return_date - borrow_date).to_i
      update(borrowed_days: time_difference)

      delay = time_difference
      BorrowHistoryWorker.perform_in(delay, id)
    end
  end
 # after_commit :schedule_notification_job

end
