class Category < ApplicationRecord
  extend Mobility
include CategoriesHelper
  has_many :book_categories
  has_many :books, through: :book_categories
  validates :name, presence: true, uniqueness: true
  translates :name, type: :string, locale_accessors: I18n.available_locales
end
