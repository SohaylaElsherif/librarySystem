class AddLocalizedNamesToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :localized_title, :string
    add_column :books, :localized_author, :string
  end
end
