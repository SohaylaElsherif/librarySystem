class RemoveLocalizedNameFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :localized_name, :string

  end
end
