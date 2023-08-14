class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :dateOfBirth

  attribute :otp_secret, if: Proc.new { |user| user.otp_secret.present? }

  has_many :borrow_histories
  has_many :reviews
  has_many :notifications
end
