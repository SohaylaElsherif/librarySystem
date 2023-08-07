class AddAdminUserToBorrowHistories < ActiveRecord::Migration[7.0]
  def change
    add_reference :borrow_histories, :admin_user,
  end
end
