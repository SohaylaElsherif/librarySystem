module ShelvesHelper
  extend ActiveSupport::Concern
  included do
    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "max", "number_of_books", "updated_at"]
      end
  def self.ransackable_associations(auth_object = nil)
    ["books"]
  end
  def set_defaults
    number_of_books = 0
  end
end
end
