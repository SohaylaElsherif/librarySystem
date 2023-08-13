# frozen_string_literal: true
module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      include JsonWebToken
      respond_to :json

      def create
        build_resource(sign_up_params)

        if resource.valid?  && resource.save
          generate_token_and_return(resource)
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def generate_token_and_return(user)
        token = JsonWebToken.encode({ user_id: user.id, email: user.email })
        send_otp_verification(user)
        render json: { message: 'User successfully registered', token: token }, status: :created
      end

      def send_otp_verification(user)
        UserMailer.send_otp_secret_email(resource).deliver_now
      end
    end
  end
end
