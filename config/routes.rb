Rails.application.routes.draw do
  resources :campyears do
    resources :camps, shallow: true
  end

  resources :teams
  get '/teams/catalogue/:id', to: 'teams#catalogue', as: 'teams_catalogue'

  resources :helpers
  get '/mitarbeiteranmeldung', to: 'helpers#new'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'admin/dashboard'
  get 'admin/dev'

  get 'login', to: 'session#login'
  post 'login', to: 'session#auth'
  get 'logout', to: 'session#logout'

  get "downloads", to: 'home#downloads'
  get 'spenden', to: 'home#spenden'

  resources :pages
  resources :events
  resources :messages

  # resource :participants

  root "home#index"
end
