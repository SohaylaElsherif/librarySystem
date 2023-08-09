class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user, presence: true
  validates :book, presence: true
  validates :rating , numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :review_type, presence: true


  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "comment", "created_at", "id", "rating", "review_type", "updated_at", "user_id"]
  end
end
