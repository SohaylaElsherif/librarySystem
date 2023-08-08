ActiveAdmin.register Book do
  permit_params :title, :author, :shelf_id, :available, :position,category_ids: []

  index do
    selectable_column
    id_column
    column :title
    column :author
    column :shelf
    column :available
    column :position
    actions
  end

  filter :title
  filter :author
  filter :available
 # filter :shelf, as: :select, collection: -> { Shelf.pluck(:number_of_books, :id) }
  filter :categories, as: :check_boxes

  form do |f|
    f.inputs "Book Details" do
      f.input :title
      f.input :author
      f.input :available
      f.input :position
      f.input :shelf
      f.input :categories, as: :check_boxes, collection: Category.pluck(:name, :id)
    end
    f.actions
  end
end
