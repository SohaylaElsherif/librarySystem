class BookSerializer
  include JSONAPI::Serializer

  attribute :title do |book|
    localized_attribute(book, :title)
  end

  attribute :author do |book|
    localized_attribute(book, :author)
  end

  attribute :rating
  attribute :review_count
  has_many :categories

  def localized_attribute(record, attribute)
    locale = params[:locale] || I18n.locale
    record.send("#{attribute}_locale", locale.to_sym)
  end
end