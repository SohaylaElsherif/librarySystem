ActiveAdmin.register Book do
  permit_params :title, :author, :shelf_id, :category_1_id, :category_2_id, :category_3_id, :available, :position

  index do
    selectable_column
    id_column
    column :title
    column :author
    column :shelf
    column :category_1
    column :category_2
    column :category_3
    actions
  end

  filter :title
  filter :author
  filter :shelf
  filter :category_1
  filter :category_2
  filter :category_3

  form do |f|
    existing_shelf = Shelf.where("number_of_books < ?", 5).first

    if existing_shelf
      # Use an existing shelf with number < 5 (max shelf number)
      f.inputs "Book Details" do
        f.input :title
        f.input :author
        f.input :shelf, as: :select, collection: [existing_shelf], include_blank: false
        f.input :category_1
        f.input :category_2
        f.input :category_3
      end
      existing_shelf.number_of_books +=1
      existing_shelf.save
    else
      # Create a new shelf with default number = 1
      new_shelf = Shelf.create(number_of_books: 1)

      f.inputs "Book Details" do
        f.input :title
        f.input :author
        f.input :shelf, as: :select, collection: [new_shelf], include_blank: false
        f.input :category_1
        f.input :category_2
        f.input :category_3
      end
    end

    f.actions
  end
end
