Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  get 'pending_borrow_requests/index'
  get 'pending_borrow_requests/create'
  get 'pending_borrow_requests/update'
  get 'pending_borrow_requests/destroy'
  resources :pending_borrow_requests, only: [:index, :show, :create, :update, :destroy]
  root 'home_page#index'
end
