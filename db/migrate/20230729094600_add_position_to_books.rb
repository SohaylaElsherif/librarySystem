class AddPositionToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :position, :integer
  end
end
