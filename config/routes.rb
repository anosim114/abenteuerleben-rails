Rails.application.routes.draw do
  resources :campyears do
    resources :camps, shallow: true
  end

  resources :teams
  get '/teams/catalogue/:id', to: 'teams#catalogue', as: 'teams_catalogue'

  resources :helpers
  get '/excel/helpers', to: 'helpers#excelify'
  get '/mitarbeiteranmeldung', to: 'helpers#new'

  get '/kinderanmeldung', to: 'child_registrations#index', as: 'child_registration'
  get '/kinderanmeldung/basis-daten', to: 'child_registrations#new_name', as: 'child_registration_new_name'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'admin/dashboard'
  get 'admin/dev'

  get 'login', to: 'session#login'
  post 'login', to: 'session#auth'
  get 'logout', to: 'session#logout'

  get 'downloads/admin', to: 'downloads#admin'
  resources :downloads

  resources :pages
  resources :events
  resources :messages

  # resource :participants

  root "home#index"
end
