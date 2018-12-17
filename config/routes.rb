Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :users do
    member do
      get "artworks", to: "feeds#artworks", feed_type: :created
      get "artwork_reblogs", to: "feeds#artwork_reblogs", feed_type: :created
      get "scraps", to: "feeds#scraps", feed_type: :created
      get "verify_email"
      get "unsubscribe"
    end
  end


  resources :sessions do
    collection do
      delete "logout"
    end
  end

  concern :commentable do |options|
    resources :comments, options
  end

  resources :scraps do
    concerns :commentable, commentable_type: "Scrap"
  end

  resources :artworks do
    concerns :commentable, commentable_type: "Artwork"
  end

  resources :followings, only: [:create, :destroy]

  resources :tags

  resources :artwork_reblogs

  resources :notifications, only: [:index, :show, :update, :destroy] do
    get "unread", on: :collection
  end

  scope "feeds" do
    get "/", to: "feeds#index"
    get "artworks", to: "feeds#artworks"
    get "scraps", to: "feeds#scraps"
    get "artwork_reblogs", to: "feeds#artwork_reblogs"
  end

  scope "sitemaps", defaults: { format: "txt" } do
    get "tags", to: "sitemaps#tags"
    get "users", to: "sitemaps#users"
    get "scraps", to: "sitemaps#scraps"
    get "artworks", to: "sitemaps#artworks"
    get "/", to: "sitemaps#index"
  end

  root to: "home#index"

end
