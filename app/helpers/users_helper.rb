module UsersHelper
  def generate_otp
    self.otp_secret = rand(1000..9999).to_s.rjust(4, '0')
  end

  # Custom validation for password complexity

  private

  def password_complexity
    return if password.blank? || password =~ /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/

    errors.add :password, 'must be at least 8 characters long and contain at least one letter and one digit'
  end
end
