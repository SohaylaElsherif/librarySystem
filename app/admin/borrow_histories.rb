ActiveAdmin.register BorrowHistory do
  actions :all, except: :create

  permit_params :status

  form do |f|
    f.inputs 'Borrow History Details' do
      f.input :status, as: :select, collection: %w[accepted rejected]
    end
    f.actions
  end
end
