class Shelf < ApplicationRecord
  after_initialize :set_defaults
  has_many :books
  validates :number_of_books, numericality: { only_integer: true, less_than_or_equal_to: 5 }
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "number_of_books", "updated_at"]
    end
    def self.ransackable_associations(auth_object = nil)
      ["books"]
    end
    def set_defaults
      number_of_books = 0
    end
end
