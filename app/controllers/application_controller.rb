
class ApplicationController < ActionController::Base
  include Api

   include ActionController::Helpers
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

around_action :switch_locale

def switch_locale(&action)
  locale = params[:locale] || I18n.default_locale
  I18n.with_locale(locale, &action)
end
def default_url_options
  { locale: I18n.locale }
end


  config.load_defaults 7.0
  skip_before_action :verify_authenticity_token

  def decoded_auth_token
    decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    headers['Authorization'].split(' ').last if headers['Authorization'].present?
  end

end
