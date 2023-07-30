class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
       #   otp_secret_encryption_key: ENV['OTP_SECRET_KEY']

  # include Devise::JWT::RevocationStrategies::JTIMatcher

  # Define your role-related logic here, e.g., using a 'role' column
  # def roles
  #   [role.to_sym]
  # end

  has_many :borrow_histories
  has_many :reviews
  def self.ransackable_attributes(auth_object = nil)
    ["consumed_timestep", "created_at", "email", "encrypted_password", "id", "otp_required_for_login", "otp_secret", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
    end
    def self.ransackable_associations(auth_object = nil)
      ["borrow_histories", "reviews"]
    end
end
