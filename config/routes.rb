Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :chefs, only: %i[new create update] do
    member do
      get :confirm_email
    end
  end

  resources :clients, only: %i[new create]

  delete 'chefs/logout', to: 'chef/sessions#destroy'
  post 'chefs/login', to: 'chef/sessions#create'
  get 'chefs/dashboard', to: 'chef/dashboard#show'
end
