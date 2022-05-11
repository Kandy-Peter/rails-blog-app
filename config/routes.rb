Rails.application.routes.draw do
  root "users#index"
  get 'users/:id' => 'users#show'
  get 'users/:id/posts'=> 'posts#index'
  get 'users/:id/posts/:post_id' => 'posts#show'
end
