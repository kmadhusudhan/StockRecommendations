Rails.application.routes.draw do
  resources :stocks
  resources :recommendations
  root to: 'home#index'
  # devise_scope :user do
  #   root to: 'users/sessions#new'
  # end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users
  post '/recommendations/vote', to: 'recommendations#vote'
  post '/stocks/follow', to: 'stocks#follow'
  # post '/stocks/unfollow', to: 'stocks#unfollow'
  get '/dashboards', to: 'dashboards#index'
  post '/subscribe', to: 'subscriptions#create'
  post '/push', to: 'push_notifications#create'
  get '/roles', to: 'roles#index'
  post '/roles/change_role', to: 'roles#change_role'

  resources :males, controller: 'users', type: 'Male'
  resources :females, controller: 'users', type: 'Female'

  namespace :api do
    namespace :v1 do
      resources :subscriptions, only: :create
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
