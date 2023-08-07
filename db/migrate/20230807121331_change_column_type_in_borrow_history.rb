class ChangeColumnTypeInBorrowHistory < ActiveRecord::Migration[7.0]
  def change
    change_column :borrow_histories , :status, :integer, using: 'status::integer'
  end
end
