class Shelf < ApplicationRecord
  has_many :books
  validates :number_of_books, numericality: { only_integer: true, less_than_or_equal_to: 5 }

end
