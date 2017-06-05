Rails.application.routes.draw do
  root "roots#show"

  get '/auth/github/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  resource :profile, only: :show
  resources :messages, only: :create
  resources :api_keys, only: :new

  resources :clients do
    resources :channels do
      resources :channel_transports, only: [:new, :create, :destroy]
    end

    namespace :transports do
      resources :telegrams
    end

    scope module: :clients do
      resources :users, param: :username
      resources :teams, param: :name
    end
  end

  # === API resources ===
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      concern :user_routes do
        resources :tokens, only: :create
      end

      scope(:user) { concerns :user_routes }
      resources :users, only: [], concerns: :user_routes

      resources :clients
    end
  end

  mount ResqueWeb::Engine => "/resque_web"
end
