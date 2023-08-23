class NotificationSerializer
  include JSONAPI::Serializer

  attributes :message

  belongs_to :user
  belongs_to :admin_user
end
