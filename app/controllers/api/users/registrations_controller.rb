# frozen_string_literal: true
module Api
    class Users::RegistrationsController < Devise::RegistrationsController
      include JsonWebToken
      respond_to :json

      def create
        @user=User.new(sign_up_params)

        if user.valid?  &&  @user.save!
          generate_token_and_return(user)
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def generate_token_and_return(user)
        token = JsonWebToken.encode({ user_id: user.id, email: user.email })
        send_otp_verification(user)
      #  redirect_to api_verify_otp_path , allow_other_host: true
        render json: { message: 'User successfully registered , confirm your email ', otp_code: user.otp_secret }, status: :created
      end

      def send_otp_verification(user)
  #      UserMailer.send_otp_secret_email(resource).deliver_now
   puts user.otp_secret
      end
    end
end
