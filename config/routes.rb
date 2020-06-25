Rails.application.routes.draw do
  resources :comments, only: %i[create destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/user:id', to: 'users#show', as: 'user'
  namespace :admin do
    resources :users
  end

  root to: 'tasks#index'
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
  end
end
