Rails.application.routes.draw do
  devise_for :users
  resources :posts do
  	resources :comments
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end

  resources :projects do
    resources :tasks
  end

  resources :tasks do
  end

  root 'pages#home'

  get 'post_index' => 'posts#index', as: 'post_index'

  get 'project_index' => 'projects#index', as: 'project_index'

  get 'account' => 'users#account', as: 'account'

<<<<<<< HEAD
=======
  get 'kanban' => 'users#kanban', as: 'kanban'

>>>>>>> 8739b5169ea697cf068630df20ebff374095f5b2
end
