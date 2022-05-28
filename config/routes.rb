# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/(:locale)', locale: /en|ru/ do
    devise_for :users
    root 'home#index'

    resources :posts, except: [:index]
  end
end
