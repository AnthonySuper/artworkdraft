Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :users


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

  root to: "home#index"

end
