class MakeUserIdsNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :borrow_histories, :admin_user_id, true
  end
end
