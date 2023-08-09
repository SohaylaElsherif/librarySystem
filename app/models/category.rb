class Category < ApplicationRecord
  extend Mobility

  has_many :book_categories
  has_many :books, through: :book_categories
  validates :name, presence: true, uniqueness: true
  translates :name, type: :string, locale_accessors: I18n.available_locales

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at" ,"book_id"]
    end
    def self.ransackable_associations(auth_object = nil)
      ["book_categories", "books"]
    end
end
