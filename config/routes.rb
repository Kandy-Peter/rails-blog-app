Rails.application.routes.draw do
  root 'index#users'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
