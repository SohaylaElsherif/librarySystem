class Category < ApplicationRecord
  has_many :book_categories
  has_many :books, through: :book_categories
  validates :name, presence: true, uniqueness: true
  validates :localized_name, presence: true
  alias_attribute :name, :localized_name

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name","localized_name", "updated_at"]
    end
    def self.ransackable_associations(auth_object = nil)
      ["book_categories", "books"]
    end
end
