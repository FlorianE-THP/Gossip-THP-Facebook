Rails.application.routes.draw do
  get 'city/show'
  get 'user/show'
  get 'gossips/find'
  root 'home#index'
  get '/welcome/:first_name', to: 'welcome#say_hello', as: "landing"
  get '/team', to: 'team#show'
  get '/contact', to: 'contact#show'
  resources :gossips 
  resources :comment
  resources :home
  resources :user
  resources :city
  resources :sessions

end
