# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/(:locale)', locale: /en|ru/ do
    devise_for :users
    root 'posts#index'

    resources :posts
  end
end
