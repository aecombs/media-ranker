Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'

  resources :pizzas
  resources :users do
    resources :votes, only: [:index, :create]
  end
  resources :votes, only: [:index]
end