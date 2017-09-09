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

end
