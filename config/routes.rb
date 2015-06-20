Rails.application.routes.draw do
  resources :apps, only: [ :update, :index, :show, :create ]

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  resource :home, only: [ :index ]
  root 'home#index'

end
