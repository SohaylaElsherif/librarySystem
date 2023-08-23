# frozen_string_literal: true
module Api
    class Users::RegistrationsController < Devise::RegistrationsController
      include JsonWebToken
      respond_to :json

      def create
        begin
        @user = User.create(sign_up_params)
        @user.save!
        generate_token_and_return(@user)
      rescue => e
        return response_record_error(@user) if @user&.errors&.any?
        return response_record_error(@device) if @device&.errors&.any?
        raise ExceptionHandler::UnprocessableEntity.new(error: e.message, message: e.message)
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
