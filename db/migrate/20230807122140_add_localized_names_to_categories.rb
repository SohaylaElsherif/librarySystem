class AddLocalizedNamesToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :localized_name, :string

  end
end
