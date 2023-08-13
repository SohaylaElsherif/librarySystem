module BooksHelper
  extend ActiveSupport::Concern
  included do
    def self.ransackable_associations(auth_object = nil)
      ["borrow_histories", "book_categories", "reviews", "shelf" ,"categories"]
    end
    def self.ransackable_attributes(auth_object = nil)
      ["author", "available", "created_at", "id", "position", "rating", "shelf_id", "title", "updated_at"]
    end

    def calculate_rate_and_review_count
      self.reviewscount = reviews.count
      self.rating = (reviews.sum(:rating) / reviewcount.to_f) * 5 unless reviewcount.zero?
      save
    end
    def ensure_shelf_limit
      errors.add(:shelf_id, "no space") if self.class.where(shelf_id: self.shelf_id).where.not(id: self.id).count >= 5
    end

  end
end
