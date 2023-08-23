class BorrowHistory < ApplicationRecord
  include BorrowHistoryHelper
  extend Mobility

  belongs_to :user
  belongs_to :book
  has_one :approved_by, class_name: :AdminUser , foreign_key: "admin_user_id"

  validates_presence_of :status
  validates :user, presence: true
  validates :book, presence: true
  validates :borrow_date, presence: true
  validate :borrow_date_cannot_be_in_past

  enum status: {
    pending: 0,
    accepted: 1,
    rejected: 2,
    borrowed: 3,
    done: 4
  }

  before_create :check_date_range_with_accepted_or_done
  after_commit :schedule_status_change_and_notifications, on: :update, if: :saved_change_to_status?
  after_commit :schedule_review_creation_job, on: :update, if: :saved_change_to_status?

 # after_commit :schedule_notification_job

end
