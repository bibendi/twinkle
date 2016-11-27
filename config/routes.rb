Rails.application.routes.draw do
  mount ResqueWeb::Engine => "/resque_web"

  get '/auth/github/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  root "roots#show"

  resources :messages, only: :create

  resources :clients do
    resources :channels do
      resources :channel_transports, only: [:new, :create, :destroy]
    end

    namespace :transports do
      resources :telegrams
    end
  end
end
