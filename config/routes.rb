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
    member do
      put "like", to: "projects#upvote"
    end
  end

  resources :tasks do
    put 'accept_task', to: 'tasks#accept_task'
  end

  root 'pages#home'

  get 'post_index' => 'posts#index', as: 'post_index'

  get 'project_index' => 'projects#index', as: 'project_index'

  get 'task_index' => 'tasks#index', as: 'task_index'

  get 'account' => 'users#account', as: 'account'

  get 'kanban' => 'users#kanban', as: 'kanban'

end
