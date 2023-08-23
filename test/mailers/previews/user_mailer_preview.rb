# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_otp_secret_email(user)
    @user = user
    mail(to: user.email, subject: 'Your OTP Secret' ,message: user.otp_secret )
  end
end
