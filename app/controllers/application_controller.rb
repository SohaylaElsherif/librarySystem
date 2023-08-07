
class ApplicationController < ActionController::Base
  include ObjectSetter # Include the ObjectSetter module

  include JsonWebToken
    config.load_defaults 7.0
    skip_before_action :verify_authenticity_token

    def decoded_auth_token
      decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
        end

    def http_auth_header
      headers['Authorization'].split(' ').last if headers['Authorization'].present?
    end
    before_action :set_locale

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

end
