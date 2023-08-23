class ReviewCreationWorkerWorker
  include Sidekiq::Worker

    def perform(borrow_history_id)
      borrow_history = BorrowHistory.find(borrow_history_id)
      return unless borrow_history.status == 'borrowed'

      user = borrow_history.user
      book = borrow_history.book

      review = Review.create(user: user, book: book, review_type: 'user-book')
    end
end
