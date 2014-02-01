GhstreaksService::Application.routes.draw do
  resources :users, defaults: {format: :json}
  get '/streaks/:user', controller: :streaks, action: :index, defaults: {format: :json}
  get '/notifications/search', controller: :notifications, action: :search, defaults: {format: :json}, as: :notification_search
  resources :notifications, defaults: {format: :json}
end
