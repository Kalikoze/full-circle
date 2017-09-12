Rails.application.routes.draw do
  root 'homepage#index'

  get '/auth/github/callback', to: 'sessions#create'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end

  namespace :reviewer do
    get '/dashboard', to: 'dashboard#index'
  end

  namespace :student do
    get '/dashboard', to: 'dashboard#index'
  end

  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :applications, only: [:index]
      end
    end
  end

end
