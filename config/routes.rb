Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/unprocessable_entity'

  get 'errors/internal_server_error'

  get 'errors/bad_request'

  resources :artists do
    member do
      patch '/favorite', action: 'favorite'
    end
  end

  resources :records do
    member do
      patch '/favorite', action: 'favorite'
    end
    resources :songs do
      member do
        patch '/favorite', action: 'favorite'
      end
    end
  end

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
