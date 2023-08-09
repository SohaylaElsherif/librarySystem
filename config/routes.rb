Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ar/ do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  namespace :api do
    namespace :v1 do
      resources :borrow_histories, only: [:index, :show, :create, :update, :destroy]
      resources :reviews, only: [:create, :update, :index]
      resources :notifications, only: [:index, :show]

    end
  end

  post '/verify_otp', to: 'users/otp_verifications#create', as: 'verify_otp'

  root to: "library/home_page#index"

  namespace :library, path: "/" do
    resources :books

    # Now we have params[:locale] available
    # in our controllers and views
    root to: "home_page#index"
    end

  end
end
