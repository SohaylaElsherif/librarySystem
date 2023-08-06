Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :books
      resources :pending_borrow_requests, only: [:index, :show, :create, :update, :destroy]
    end
  end
  get 'pending_borrow_requests/index'
  get 'pending_borrow_requests/create'
  get 'pending_borrow_requests/update'
  get 'pending_borrow_requests/destroy'
  post '/verify_otp', to: 'users/otp_verifications#create', as: 'verify_otp'
  root 'home_page#index'
end
