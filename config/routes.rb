Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :appointments
      resources :engineers
      resources :users, only: [:create]
      post '/login', to: 'users#login'
      get '/auto_login', to: 'users#auto_login'
      delete '/logout', to: 'users#logout'
    end
  end
  root to: 'static#index'
end
