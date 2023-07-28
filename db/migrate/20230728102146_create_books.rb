class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.references :shelf, null: false, foreign_key: true
      t.references :category_1, foreign_key: { to_table: :categories }
      t.references :category_2, foreign_key: { to_table: :categories }
      t.references :category_3, foreign_key: { to_table: :categories }
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
