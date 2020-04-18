Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :chefs, only: [:new, :create]

  get 'chefs/dashboard', to: 'chef/dashboard#show'
end
