require 'sidekiq/web'

Rails.application.routes.draw do
  apipie
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: :create
      resources :videos, only: %i[index create]
      resources :requests, only: :index do
        scope module: :requests do
          resource :restarting, only: :create
        end
      end
    end
  end
end
