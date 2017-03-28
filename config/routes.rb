Rails.application.routes.draw do
  resources :offenders, only: %i[show]
  resource :sessions, only: %i[new create destroy]

  resources :notifications, only: %i[new create]

  get '/notification-systems', to: 'home#notification_systems'
  root to: 'home#index'
end