# frozen_string_literal: true

Rails.application.routes.draw do
  resources :campyears do
    resources :camps, shallow: true
  end

  resources :teams
  get '/teams/catalogue/:id', to: 'teams#catalogue', as: 'teams_catalogue'

  ############################
  # helper registration related
  ############################
  resources :helpers
  get '/excel/helpers', to: 'helpers#excelify'
  get '/mitarbeiteranmeldung', to: 'helpers#new'
  # --------------------------

  ############################
  # child registration related
  ############################
  get '/kinderanmeldung', to: 'parent/parents#index'
  get '/parents/:id/resend_verification_mail', to: 'parent/parents#resend_registration_email'
  namespace :parent, only: %i[index new create] do
    resources :names, only: %i[new create]
    resources :locations, only: %i[new create]
    resources :contacts, only: %i[new create]
    resources :optionals, only: %i[new create]
    resources :child_stats, only: %i[new create]
    resources :parents, only: %i[index new create]
  end

  resources :children
  # --------------------------

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

  root 'home#index'
end
