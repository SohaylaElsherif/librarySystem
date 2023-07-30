ActiveAdmin.register Shelf do
  actions :all, except: [:edit, :update]

  permit_params :number_of_books

  index do
    selectable_column
    id_column
    column :number_of_books
    actions
  end

  form do |f|
    f.inputs "Shelf Details" do
      f.input :number_of_books
    end
    f.actions
  end
end
