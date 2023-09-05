Rails.application.routes.draw do
  resources :events
  resources :pages
  get 'admin/dashboard'
  get '/login', to: 'session#login'
  post '/login', to: 'session#auth'
  get '/logout', to: 'session#logout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get "/downloads", to: 'home#downloads'
  get '/spenden', to: 'home#spenden'

  resources :messages
  scope '/admin' do
    
  end

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

  root "home#index"
end
