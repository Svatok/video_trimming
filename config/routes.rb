Rails.application.routes.draw do
  apipie

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: :create
    end
  end
end
