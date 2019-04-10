Rails.application.routes.draw do
  devise_for :users
  resources :posts do
  	resources :comments
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
  end

  resources :projects do
    get 'available_tasks', to: 'projects#available_tasks'
    get 'hub', to: 'projects#hub'
    get 'discussion', to: 'projects#discussion'
    resources :tasks
    get 'progress_task', to: 'tasks#progress_task'
    get 'regress_task', to: 'tasks#regress_task'
    post 'review_task', to: 'tasks#review_task'
    member do
      get "like", to: "projects#upvote"
    end
  end

  resources :tasks do
    get 'request_task', to: 'tasks#request_task'
    get 'accept_user', to: 'tasks#accept_user'
    get 'drop_task', to: 'tasks#drop_task'
    get 'progress_task', to: 'tasks#progress_task'
    get 'regress_task', to: 'tasks#regress_task'
    post 'review_task', to: 'tasks#review_task'
  end

  resources :user do
    get 'resume_search', to: 'users#resume_search'
    get 'new_message', to: 'users#new_message'
    post 'message', to: 'users#message'
  end

  resources :resumes

  root 'pages#home'

  get 'post_index' => 'posts#index', as: 'post_index'

  get 'project_index' => 'projects#index', as: 'project_index'

  get 'task_index' => 'tasks#index', as: 'task_index'

  get 'account' => 'users#account', as: 'account'

  get 'kanban' => 'users#kanban', as: 'kanban'

  get 'resume_index' => 'resume#index', as: 'resume_index'
end
