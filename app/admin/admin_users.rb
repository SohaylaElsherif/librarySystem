ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation



  member_action :notifications, method: :get do
    @admin_user = AdminUser.find(params[:id])
    @notifications = @admin_user.notifications

    respond_to do |format|
      format.json { render json: @notifications }
    end
  end

  action_item :notifications, only: :show do
    link_to "View Notifications", notifications_admin_admin_user_path(admin_user, format: :json)
  end

  # Define the notifications page as a resource
  controller do
    def notifications
      @admin_user = AdminUser.find(params[:id])
      @notifications = @admin_user.notifications
    end
  end

  # Define the notifications index page
  config.clear_action_items!
  action_item :notifications, only: :index do
    link_to "View Notifications", notifications_admin_admin_user_path(current_admin_user)
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

end
