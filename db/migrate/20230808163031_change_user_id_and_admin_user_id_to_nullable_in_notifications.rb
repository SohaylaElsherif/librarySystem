class ChangeUserIdAndAdminUserIdToNullableInNotifications < ActiveRecord::Migration[7.0]
  def change
    change_column_null :notifications, :user_id, true
    change_column_null :notifications, :admin_user_id, true
  end
end
