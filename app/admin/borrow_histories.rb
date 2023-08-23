ActiveAdmin.register BorrowHistory do
  actions :all, except: :create

  permit_params :status
  index do
    selectable_column
    column :status
    column :book_id
    column :user_id
    column :borrow_date, format: :short
    column :return_date, format: :short
    actions
  end

  form do |f|
    f.inputs 'Borrow History Details' do
      f.input :status, as: :select, collection: %w[accepted rejected]
    end
    f.actions
  end
end
