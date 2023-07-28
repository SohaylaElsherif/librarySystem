class CreateBorrowHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :borrow_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :borrow_date
      t.date :return_date
      t.integer :borrowed_days
      t.string :status

      t.timestamps
    end
  end
end
