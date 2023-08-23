class Book < ApplicationRecord
  include BooksHelper

  extend Mobility

  belongs_to :shelf
  has_many :borrow_histories
  has_many :reviews
  has_many :book_categories
  has_many :categories, through: :book_categories

  validates_presence_of :title, :author
  validates_inclusion_of :available, in: [true, false]
  validates_inclusion_of :rating, in: 0..5

  translates :title, type: :string, locale_accessors: I18n.available_locales
  translates :author, type: :string, locale_accessors: I18n.available_locales

  after_update :calculate_rate_and_review_count

  validate :ensure_shelf_limit, if: -> { self.shelf_id.present? && self.shelf_id_changed? }

end
