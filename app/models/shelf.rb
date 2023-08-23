class Shelf < ApplicationRecord
include ShelvesHelper
  has_many :books
 # after_initialize :set_defaults
  validates :number_of_books, numericality: { only_integer: true, less_than_or_equal_to: 5 }

end
