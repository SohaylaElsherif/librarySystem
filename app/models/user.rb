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
end
