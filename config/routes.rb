Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  root to: 'homepages#index'
  
  resources :pizzas
  resources :users, only: [:index, :show] do
    resources :votes, only: [:index, :create]
  end
end