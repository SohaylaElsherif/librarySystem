module ReviewsHelper
  extend ActiveSupport::Concern
  included do
    def self.ransackable_attributes(auth_object = nil)
      ["book_id", "comment", "created_at", "id", "rating", "review_type", "updated_at", "user_id"]
      end
    def self.ransackable_attributes(auth_object = nil)
      ["book_id", "comment", "created_at", "id", "rating", "review_type", "updated_at", "user_id"]
    end
  end
end
