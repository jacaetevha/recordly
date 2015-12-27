Rails.application.routes.draw do
  # account creation routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # session control routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # root of the application
  root to: 'records#index'
end
