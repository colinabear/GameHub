Rails.application.routes.draw do

  root 'pages#home', as: 'home'

  get 'account' => 'pages#account', as: 'account'

<<<<<<< HEAD
  get 'create_account' => 'pages#create_account', as: 'create_account'

  get 'forum' => 'game_post#forum', as: 'forum'
=======
  get 'new' => 'users#new', as: 'new'
>>>>>>> f473e73c47dcbbeceaa2f5496cf7fea297dda399
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :posts
end
