Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get '/users', to: 'posts#index'
  resources :users, only: [] do
    resources :posts
  end
end
