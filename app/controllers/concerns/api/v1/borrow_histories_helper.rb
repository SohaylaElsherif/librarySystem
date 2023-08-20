module Api::V1::BorrowHistoriesHelper

  def display_date(date)
    date.strftime('%Y-%m-%d')
  end

  # Custom validation method to check date range with accepted or done status
  def check_date_range_with_accepted_or_done
    @overlapping_borrows = BorrowHistory.where(book_id: book_id)
                                      .where('(borrow_date, return_date) overlaps (?, ?)', borrow_date, return_date)
                                      .where(status: [:accepted, :borrowed])
    if @overlapping_borrows.exists?
      errors.add(:base, 'Book already borrowed or accepted for the selected date range')
    end

  end

  def borrow_date_cannot_be_in_past
    if borrow_date.present? && borrow_date < Date.today
      errors.add(:borrow_date, "can't be in the past ")
    end
  end


  #def schedule_notifications
   # if status == 'accepted' && borrow_date == Date.today
    #  BorrowAcceptedNotificationJob.perform_async(id)
    #end

    #if status == 'accepted' || status == 'borrowed'
     # BorrowReturnNotificationJob.perform_at(return_date.tomorrow, id)
    #end
 # end

  #def schedule_notification_job
  #  time_difference = (return_date - Time.zone.now).to_i
  #  delay = time_difference > 0 ? time_difference : 0

   # NotificationWorkerJob.perform_in(delay, id)
    #end


    def set_borrow_history
      @borrow_history = BorrowHistory.find(params[:id])
    end

    def borrow_history_params
      params.require(:borrow_history).permit(:book_id, :borrow_date, :return_date)
    end

    def send_custom_notification(borrow_history)
      # a Notification model to store notifications
      Notification.create(
        user_id: borrow_history.user_id,
        message: "Your book request for Book ID #{borrow_history.book_id} is pending."
      )
    end
end
