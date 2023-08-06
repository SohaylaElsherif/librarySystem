class AddAdminIdToBorrowHistories < ActiveRecord::Migration[7.0]
  def change
    add_column :borrow_histories, :admin_id, :bigint
  end
end
