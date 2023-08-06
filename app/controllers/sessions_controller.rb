class SessionsController < ApplicationController
  include JsonWebToken

  # Specify that this controller only responds to JSON format
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      token = JsonWebToken.encode({ user_id: user.id, email: user.email })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  def destroy
    # Assuming you have the current_user method defined in ApplicationController
    current_user = User.find_by(id: JsonWebToken.decode(params[:token])[:user_id])

    if current_user
      # Invalidate the user's token by setting it to nil or some other value
      # For example, you can use a revoked_token column in the User model
      # current_user.update(revoked_token: some_unique_value)

      render json: { message: 'User successfully signed out' }, status: :ok
    else
      render json: { error: 'Invalid token or user not found' }, status: :unprocessable_entity
    end
  end
  def verify_otp
    user = User.find_by(email: params[:user_email])

    if user && user.valid_otp?(params[:otp_secret])
      render json: { message: 'OTP successfully verified' }, status: :ok
    else
      render json: { error: 'Invalid OTP or user not found' }, status: :unprocessable_entity
    end
  end
end
