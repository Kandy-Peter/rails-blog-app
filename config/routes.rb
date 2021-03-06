Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end

  namespace :api do
    namespace :v1 do
      post "login" => "users#login"
      get "users" => "users#index"
      get "user/posts" => "posts#index"
      get "post/comments" => "comments#index"
      get "post/comments/create" => "comments#create"
    end
  end
end
