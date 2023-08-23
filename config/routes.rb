Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ar/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    namespace :api do

      devise_for :users, controllers: {
        registrations: 'api/users/registrations',
        sessions: 'api/users/sessions',
        passwords: 'api/users/passwords'
      }
      namespace :v1 do
        resources :borrow_histories, only: [:index, :show, :create, :update, :destroy] do
          resources :reviews, only: [:create, :update, :index]
          resources :notifications, only: [:index, :show]
        end
       resources :books , only: [:index, :show]
      end
      post 'users/verify_otp', to: 'users/otp_verifications#create'

    end


    root to: "home_page#index"
  end
end
