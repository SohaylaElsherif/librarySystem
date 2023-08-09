class RemoveLocalizedNamesFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :localized_title, :string
    remove_column :books, :localized_author, :string
  end
end
