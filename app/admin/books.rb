ActiveAdmin.register Book do

  permit_params :title, :author, :available, :position , :localized_title , :localized_author , category_ids: []
  index do
    selectable_column
    id_column
    column :title
    column :author
    column :category_ids
    column :shelf_id
    column :localized_title
    column :localized_author
#    column :categories do |book|
#      book.categories.pluck(:name).join(', ')
#    end
    actions
  end

  filter :title
  filter :author
 # filter :shelf, as: :select, collection: proc { Shelf.pluck(:id, :number_of_books) }, input_html: { multiple: true }
 # filter :categories, as: :check_boxes, collection: -> { Category.pluck(:id) }

  form do |f|
    f.inputs "Book Details" do
      f.input :title
      f.input :author
      f.input :available
      f.input :position
      f.input :localized_title
      f.input :localized_author
      f.input :categories, as: :check_boxes, collection: Category.all
    end
    f.actions
  end
end
