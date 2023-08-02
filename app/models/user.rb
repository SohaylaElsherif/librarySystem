class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pending_borrow_requests
  has_many :borrow_histories
  has_many :reviews

  def self.ransackable_attributes(auth_object = nil)
    ["consumed_timestep", "created_at", "email", "encrypted_password", "id", "otp_required_for_login", "otp_secret", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
    end
    def self.ransackable_associations(auth_object = nil)
      ["borrow_histories", "reviews"]
    end
end

