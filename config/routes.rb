Rails.application.routes.draw do
  # get 'articles/index'
  # get 'articles/show'
  # get 'articles/create'
  # get 'articles/update'
  # get 'articles/destroy'
  delete 'articles/:id', to: "articles#destroy"
  resources :articles, only: [:index, :show, :create, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
