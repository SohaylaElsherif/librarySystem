class ReviewSerializer
  include JSONAPI::Serializer

  attributes :rating, :comment

  belongs_to :user
  belongs_to :book
end
