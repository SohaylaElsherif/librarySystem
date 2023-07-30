ActiveAdmin.register BorrowHistory do
  actions :all, except: :destroy

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :user_id, :book_id, :borrow_date, :return_date, :borrowed_days, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :book_id, :borrow_date, :return_date, :borrowed_days, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
