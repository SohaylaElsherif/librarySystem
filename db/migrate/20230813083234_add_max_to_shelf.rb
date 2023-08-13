class AddMaxToShelf < ActiveRecord::Migration[7.0]
  def change
    add_column :shelves, :max, :integer
  end
end
