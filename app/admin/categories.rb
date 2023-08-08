ActiveAdmin.register Category do
  permit_params :name, :localized_name

  index do
    selectable_column
    id_column
    column :name
#    column :localized_name
    actions
  end

  filter :name
  filter :localized_name

  form do |f|
    f.inputs "Category Details" do
      f.input :name
#      f.input :localized_name
    end
    f.actions
  end
end
