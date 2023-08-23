class BorrowHistorySerializer
  include JSONAPI::Serializer

  attributes :borrow_date, :return_date, :borrowed_days, :status

  belongs_to :user
  belongs_to :book
end
