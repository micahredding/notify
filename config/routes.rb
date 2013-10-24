Notify::Application.routes.draw do

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