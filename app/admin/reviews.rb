ActiveAdmin.register Review do
  actions :all, except: [:edit, :update, :create, :destroy]

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :user_id, :book_id, :rating, :comment, :review_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :book_id, :rating, :comment, :review_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
