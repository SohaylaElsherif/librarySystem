class Review < ApplicationRecord
include ReviewsHelper
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :rating , numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :review_type, presence: true



end
