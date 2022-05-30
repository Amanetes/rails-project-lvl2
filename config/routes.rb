# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/(:locale)', locale: /en|ru/ do
    devise_for :users
    root 'posts#index'
    get '/posts/:id/comments', to: 'posts#show'
    resources :posts do
      scope module: :posts do
        resources :comments, only: %i[create destroy]
        resources :likes, only: %i[create destroy]
      end
    end
  end
end
