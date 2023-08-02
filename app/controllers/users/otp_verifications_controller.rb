class Users::OtpVerificationsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  def create
    # Find the user based on the provided email or any other identifier
    user = User.find_by(email: params[:email])

    if user
      # Generate and send the OTP code to the user via email or any other method
      otp_code = generate_otp_code
      send_otp_code(user.email, otp_code)

      # Store the generated OTP code and the user ID in the session for verification
      session[:otp_code] = otp_code
      session[:user_id] = user.id

      render json: { message: 'OTP code sent for verification' }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private

  def generate_otp_code
    # Generate the OTP code using any method you prefer (e.g., using SecureRandom or a library)
    # For this example, let's assume we generate a 6-digit OTP code
    SecureRandom.random_number(100_000..999_999).to_s
  end

  def send_otp_code(email, otp_code)
    # Implement the logic to send the OTP code to the user via email or any other method here
    # For this example, let's assume we'll print it in the console
    puts "Sending OTP code #{otp_code} to #{email}"
  end
end
