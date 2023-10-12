# frozen_string_literal: true

Rails.application.routes.draw do
  apipie

  devise_for :users

  root 'pages#home'

  resources :rooms, only: %i[create show] do
    resources :messages, only: %i[create]
  end

  resources :users, only: %i[show] do
    resources :messages, only: %i[create]
  end
end
