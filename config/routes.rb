Rails.application.routes.draw do

  #author routes
  get 'authors', to: "authors#index" # to list all authors
  get 'author', to: "authors#show" # to fetch a single author details
  post 'authors', to: "authors#create" # to create a new author

  #article routes
  delete 'articles/:id', to: "articles#destroy"
  resources :articles, only: [:index, :show, :create, :update]

  #user routes
  get 'users', to:"users#index"
  post 'user', to: "users#create"
  get 'user/:id/articles', to:"users#show"

  # Defines the root path route ("/")
  # root "articles#index"
end
