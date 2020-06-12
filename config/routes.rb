Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :chefs, only: %i[new create update index] do
    member do
      get :confirm_email
    end
  end

  resources :clients, only: %i[new create]

  delete 'chefs/logout', to: 'chef/sessions#destroy'
  get 'chefs/login', to: 'chef/sessions#new'
  post 'chefs/login', to: 'chef/sessions#create'
  get 'chefs/dashboard', to: 'chef/dashboard#show'

  get 'clients/dashboard', to: 'client/dashboard#show'
  delete 'clients/logout', to: 'client/sessions#destroy'
  post 'clients/login', to: 'client/sessions#create'
  get 'clients/login', to: 'client/sessions#new'
end
