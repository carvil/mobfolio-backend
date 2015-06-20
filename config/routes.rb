Rails.application.routes.draw do
  resources :apps, only: [ :update, :index, :show, :create ]

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }
end
