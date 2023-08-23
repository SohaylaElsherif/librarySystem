class CategorySerializer
  include JSONAPI::Serializer
  attribute :name do |category|
    localized_attribute(category, :name)
  end

  def localized_attribute(record, attribute)
    locale = params[:locale] || I18n.locale
    record.send("#{attribute}_locale", locale.to_sym)
  end
end
