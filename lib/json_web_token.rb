module JsonWebToken
  # JWT secret key Make sure to set this to a secure value.
  SECRET_KEY = Rails.application.credentials.secret_key_base

  # JWT encoding method.
  def self.encode(payload)
    payload[:exp] = 24.hours.from_now.to_i # Set token expiration time (24 hours from now)
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  #  JWT decoding method.
  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })[0]
    {
      user_id: decoded_token['user_id'],
      email: decoded_token['email']
    }
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken.new(error: "invalid_token")
  end
end
