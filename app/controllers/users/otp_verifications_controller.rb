class Users::OtpVerificationsController < ApplicationController
  respond_to :json
  include JsonWebToken

  def create
    user = User.find_by(email: params[:user_email])
    if user
      # Check if the entered OTP matches the OTP stored in the user's record
      entered_otp = params[:otp_code]
      stored_otp = user[:otp_secret]

      if entered_otp == stored_otp
        # Clear the stored OTP after successful confirmation
        user[:otp_secret] = nil
        user.save

        render json: { message: 'OTP confirmed successfully' }, status: :ok
      else
        render json: { error: 'Invalid OTP' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end
end
