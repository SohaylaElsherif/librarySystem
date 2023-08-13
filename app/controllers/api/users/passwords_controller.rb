# frozen_string_literal: true
class Users::PasswordsController < Devise::PasswordsController
  before_action :authenticate_user!
  respond_to :json


  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      render json: { message: 'Reset password instructions sent' }, status: :ok
    else
      render json: { error: 'Failed to send reset password instructions' }, status: :unprocessable_entity
    end
  end


  # PATCH /users/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end

  end

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  private

  def resource_params
    params.require(:user).permit(:email)
  end
end
