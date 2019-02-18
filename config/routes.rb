Rails.application.routes.draw do

  get 'users/new'

  get 'users/show'

  root 'pages#home', as: 'home'

  get 'account', to: "pages#account"

  get 'signup', to: "users#new"

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
