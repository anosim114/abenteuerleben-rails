Rails.application.routes.draw do
  resources :campyears do
    resources :camps, except: [:index]
  end

  resources :camps, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :events
  resources :pages

  get 'admin/dashboard'

  get '/login', to: 'session#login'
  post '/login', to: 'session#auth'
  get '/logout', to: 'session#logout'

  get "/downloads", to: 'home#downloads'
  get '/spenden', to: 'home#spenden'

  resources :messages

  # resource :helpers
  # resource :participants

  root "home#index"
end
