class UserMailer < ApplicationMailer
  def send_otp_secret_email(user)
    @user = user
    mail(to: user.email, subject: 'Your OTP Secret')
  end
end
