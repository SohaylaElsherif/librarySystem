class Book < ApplicationRecord

  belongs_to :shelf
  has_many :borrow_histories
  has_many :reviews
  has_many :book_categories
  has_many :categories, through: :book_categories
  validates :title, presence: true
  validates :author, presence: true
  validates :available, inclusion: { in: [true, false] }
  validates :localized_title, presence: true
  validates :localized_author, presence: true

  # Keep the existing title and author attributes for compatibility
  alias_attribute :title, :localized_title
  alias_attribute :author, :localized_author

  validate :ensure_shelf_limit, if: -> {self.shelf_id.present? && self.shelf_id_changed?}
  def ensure_shelf_limit
    errors.add(:shelf_id, "no space") if self.class.where(shelf_id: self.shelf_id).where.not(id: self.id).count >= 5
  end


 # before_create :assign_shelf_and_category
  #railsbefore_validation :set_defaults

  def self.ransackable_attributes(auth_object = nil)
    ["author", "available", "created_at" , "id" , "title" , "updated_at", "position" ,"localized_title","localized_author" ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["borrow_histories", "book_categories", "reviews", "shelf" ,"categories"]
  end

  def ensure_shelf_limit
    errors.add(:shelf_id, "no space") if self.class.where(shelf_id: self.shelf_id).where.not(id: self.id).count >= 5
  end



  # def assign_shelf
  #   # Assign a shelf with less than 5 books or create a new shelf
  #   self.shelf = Shelf.where("number_of_books < ?", 5).first_or_create
  #   # Increment the number_of_books of the assigned shelf
  #   self.shelf.save
  # end
  # def assign_category(category_ids)
  #   self.update!(category_ids: category_ids)
  # end

  #  def set_defaults
  #   shelf = assign_shelf
  #   categories = assign_category(category_ids)
  # end
end
