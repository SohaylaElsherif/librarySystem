Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  namespace :api do
    namespace :v1 do
      resources :books
      resources :borrow_histories, only: [:index, :show, :create, :update, :destroy]
    end
  end

  post '/verify_otp', to: 'users/otp_verifications#create', as: 'verify_otp'

  # User Notifications
  resources :notifications, only: [:index, :show]


  root 'home_page#index'
end
