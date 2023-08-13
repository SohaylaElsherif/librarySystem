module ApplicationHelper
     def record_not_found(exception)
    render json: { errors: [{ title: 'Not Found', detail: exception.message }] }, status: :not_found
  end
end
