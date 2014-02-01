GhstreaksService::Application.routes.draw do
  resources :users, defaults: {format: :json}
  get '/streaks/:user', controller: :streaks, action: :index, defaults: {format: :json}
  resources :notifications, defaults: {format: :json}
end
