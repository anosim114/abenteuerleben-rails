Rails.application.routes.draw do
  resources :camps
  resources :campyears
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

  # namespace :admin do
  #   resource :helpers
  #   resource :participants
  # end

  root "home#index"
end
