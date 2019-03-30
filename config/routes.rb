Rails.application.routes.draw do
  devise_for :users
  resources :posts do
  	resources :comments
  end

  resources :projects do
    resources :comments
  end

  root 'pages#home'

  get 'post_index' => 'posts#index', as: 'post_index'

  get 'project_index' => 'projects#index', as: 'project_index'

  get 'account' => 'users#account', as: 'account'


end
