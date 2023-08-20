
class ApplicationController < ActionController::Base
  include Api

   include ActionController::Helpers
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found




def default_url_options
  { locale: I18n.locale }
end

  def set_locale_based_on_header
    locale = @lang&.scan(/^[a-z]{2}/)&.first
    locale = locale_valid?(locale) ? locale : I18n.default_locale
  end

  def locale_valid?(locale)
    I18n.available_locales.map(&:to_s).include?(locale)
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
