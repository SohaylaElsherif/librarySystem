module Api
class Users::OtpVerificationsController < ApplicationController
  respond_to :json
  include JsonWebToken
  def index
  end
  def create
    
    @user = User.find_by(email: params[:email])

   if @user.present?
      # Check if the entered OTP matches the OTP stored in the user's record
      if params[:otp_code] ==  @user.otp_secret
        # Clear the stored OTP after successful confirmation
        @user.otp_secret = nil
        @user.save!

        render json: { message: 'OTP confirmed successfully' }, status: :ok
      else
        render json: { error: 'Invalid OTP' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end
end
end
