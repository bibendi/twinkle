Rails.application.routes.draw do
  mount ResqueWeb::Engine => "/resque_web"

  root "roots#show"

  resources :messages, only: :create
end
