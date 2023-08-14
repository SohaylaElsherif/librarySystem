module UsersHelper
  extend ActiveSupport::Concern

  included do

  def self.ransackable_attributes(auth_object = nil)
  ["consumed_timestep", "created_at", "email", "encrypted_password", "id", "otp_required_for_login", "otp_secret", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["borrow_histories", "reviews" ,"notifications"]
  end
  def generate_otp
    self.otp_secret = rand(1000..9999).to_s.rjust(4, '0')
  end


  def password_complexity
    return if password.blank? || password =~ /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/

    errors.add :password, 'must be at least 8 characters long and contain at least one letter and one digit'
  end
end
end
