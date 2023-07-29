class Book < ApplicationRecord
  belongs_to :shelf
  belongs_to :category_1, class_name: 'Category', foreign_key: 'category_1_id', optional: true
  belongs_to :category_2, class_name: 'Category', foreign_key: 'category_2_id', optional: true
  belongs_to :category_3, class_name: 'Category', foreign_key: 'category_3_id', optional: true
  has_many :borrow_histories
  has_many :reviews
  validates :title, presence: true
  validates :author, presence: true
  validates :shelf, presence: true
  validates :available, inclusion: { in: [true, false] }
  def self.ransackable_attributes(auth_object = nil)
    %w[author available category_1_id category_2_id category_3_id created_at id  shelf_id title updated_at]
  end

end
