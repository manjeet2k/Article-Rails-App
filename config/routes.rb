Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "articles#index"

  resources :users, except: [:new]
  resources :articles
  resources :comments
  resources :opinions
  resources :categories

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to:  "sessions#destroy"

  get "error", to: "pages#error"


  get "article/:id/like", to: "opinions#like", as: "article_new_like"
  get "article/:id/dislike", to: "opinions#dislike", as: "article_new_dislike"

  patch "article/:id/like", to: "opinions#like", as: "article_like"
  patch "article/:id/dislike", to: "opinions#dislike", as: "article_dislike"
end
