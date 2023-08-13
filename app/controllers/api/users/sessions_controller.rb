# frozen_string_literal: true
module Api

class Users::SessionsController < Devise::SessionsController
  include JsonWebToken

  #before_action :configure_sign_in_params, only: [:create]
 # skip_before_action :verify_authenticity_token, only: :create


  # POST /resource/sign_in
  # def create
  #   super
  # end
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
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
end
