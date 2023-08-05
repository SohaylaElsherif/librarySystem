ActiveAdmin.register BorrowHistory do
  permit_params :status

  index do
    selectable_column
    id_column
    column :user
    column :book
    column :borrow_date
    column :return_date
    column :status
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :status, as: :select, collection: BorrowHistory.statuses.keys
    end
    f.actions
  end

  member_action :send_status_notification, method: :put do
    borrow_history = BorrowHistory.find(params[:id])
    if borrow_history.update(status: params[:status])
      NotificationMailer.borrow_status_change(borrow_history.user, borrow_history.status).deliver_now
      redirect_to admin_borrow_history_path(borrow_history), notice: 'Status updated successfully and notification sent.'
    else
      redirect_to admin_borrow_history_path(borrow_history), alert: 'Failed to update status.'
    end
  end

  action_item :update_status, only: :show do
    link_to 'Update Status', send_status_notification_admin_borrow_history_path(borrow_history), method: :put
  end
end
