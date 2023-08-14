Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ar/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)


    namespace :api do
      post '/verify_otp', to: 'users/otp_verifications#create', as: 'verify_otp'

      devise_for :users, controllers: {
        registrations: 'api/users/registrations',
        sessions: 'api/users/sessions',
        passwords: 'api/users/passwords'
      }
      namespace :v1 do
        resources :borrow_histories, only: [:index, :show, :create, :update, :destroy]
        resources :reviews, only: [:create, :update, :index]
        resources :notifications, only: [:index, :show]
      end
    end
    namespace :api, path: "/" do
      resources :books, only: [:index, :show]
      root to: "home_page#index"
    end
  end
end
