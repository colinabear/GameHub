Rails.application.routes.draw do
  devise_for :users
  resources :posts do
  	resources :comments
  end

  root 'pages#home'

  get 'index' => 'posts#index', as: 'index'

  get 'account' => 'users#account', as: 'account'


end
