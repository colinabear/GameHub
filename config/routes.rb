Rails.application.routes.draw do

  root 'pages#home', as: 'home'

  get 'account' => 'pages#account', as: 'account'

  get 'create_account' => 'pages#create_account', as: 'create_account'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :posts
end
