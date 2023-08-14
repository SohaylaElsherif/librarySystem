module BorrowHistoryHelper
extend ActiveSupport::Concern
included do
  def schedule_review_creation_job
    if status == 'borrowed' && return_date == Date.today
      ReviewCreationWorker.perform_in(1.day, id)
    end
  end

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
end
end
