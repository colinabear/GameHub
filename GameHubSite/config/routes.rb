Rails.application.routes.draw do

  root 'pages#home'

  get 'account' => 'pages#account'

  get "create_account" => "pages#create_account"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
