class CreateRequestAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :request_availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :borrow_date
      t.date :return_date
      t.boolean :status

      t.timestamps
    end
  end
end
