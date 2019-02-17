Rails.application.routes.draw do

  root 'pages#home', as: 'home'

  get 'account' => 'pages#account', as: 'account'

  get 'new' => 'users#new', as: 'new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
