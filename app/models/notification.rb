class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :admin_users
  validates :message, presence: true

end
