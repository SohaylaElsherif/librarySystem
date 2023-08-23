class CreateShelves < ActiveRecord::Migration[7.0]
  def change
    create_table :shelves do |t|
      t.integer :number_of_books

      t.timestamps
    end
  end
end
