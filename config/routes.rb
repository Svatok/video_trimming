Rails.application.routes.draw do
  resources :videos
  apipie

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: :create
      resources :videos, only: :create
      resources :requests, only: :index
    end
  end
end
