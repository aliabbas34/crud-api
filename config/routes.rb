Rails.application.routes.draw do

  #author routes
  get 'authors', to: "authors#index" # to list all authors
  get 'author', to: "authors#show" # to fetch a single author details
  post 'authors', to: "authors#create" # to create a new author
  get 'authors/search/:query', to: "authors#search" # to search using name or email (PR change)

  #article routes
  delete 'articles/:id', to: "articles#destroy"
  resources :articles, only: [:index, :show, :create, :update]

  # Defines the root path route ("/")
  # root "articles#index"
end
