
class ApplicationController < ActionController::Base
  include Library

  include JsonWebToken
#  def switch_locale(&action)
#    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
#    locale = extract_locale_from_accept_language_header
#    logger.debug "* Locale set to '#{locale}'"
#    I18n.with_locale(locale, &action)
#  end

#  private
#    def extract_locale_from_accept_language_header
#      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
#    end

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

