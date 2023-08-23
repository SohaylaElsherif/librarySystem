class Notification < ApplicationRecord
  include Api::V1::BorrowHistoriesHelper

  before_commit :set_notification, only: [:show, :edit, :update, :destroy]
  belongs_to :user
  belongs_to :admin_users
  validates :message, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["admin_user_id", "created_at", "id", "message", "updated_at", "user_id"]
  end

end


