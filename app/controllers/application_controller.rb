
class ApplicationController < ActionController::Base
  include JsonWebToken

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    skip_before_action :verify_authenticity_token

    def decoded_auth_token
      decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      headers['Authorization'].split(' ').last if headers['Authorization'].present?
    end

end
