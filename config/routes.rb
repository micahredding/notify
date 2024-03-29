require 'sidekiq/web'

Notify::Application.routes.draw do

  admin_constraint = lambda { |request| request.env["warden"].authenticate? and request.env['warden'].user.has_role?(:admin) }
  constraints admin_constraint do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :emails

  post "notifications/read" => "notifications#read", :as => 'notifications_read'
  resources :notifications

  post "email_filters/deactivate" => "email_filters#deactivate", :as => 'email_filters_deactivate'
  post "email_filters/activate" => "email_filters#activate", :as => 'email_filters_activate'
  resources :email_filters

  resources :rules

  get "oauth2callback" => "gmail_accounts#oauth2callback", :as => 'gmail_accounts_oauth2callback'

  get "gmail_accounts/activate" => "gmail_accounts#activate", :as => 'gmail_accounts_activate'
  resources :gmail_accounts

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users
  resources :users

end