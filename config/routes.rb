Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :chefs, only: [:new, :create]
end
