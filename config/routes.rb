Rails.application.routes.draw do
  get '/login', to: 'session#login'
  post '/login', to: 'session#auth'
  get '/logout', to: 'session#logout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

    resources :messages, only: [:new, :create]

  scope '/admin' do
    resources :messages, except: [:new, :create]
  end

  # get '/downloads'
  # get '/spenden'
  # get '/login'
  # get '/logout'
  # get '/impressum'
  # get '/datenschutz'
  # get '/quellen'

  # namespace :admin do
  #   resource :messages
  #   resource :events
  #   resource :helpers
  #   resource :participants
  # end
end
