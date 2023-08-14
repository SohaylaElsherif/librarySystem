module CategoriesHelper
extend ActiveSupport::Concern
included do
  def self.ransackable_attributes(auth_object = nil)
  ["created_at", "id", "name", "updated_at" ,"book_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["book_categories", "books"]
  end
end
end
