Rails.application.routes.draw do
  devise_for :users
  resources :service_types
  resources :parcels
  resources :addresses
  resources :users
  root to: 'search#index'
  get '/search', to: 'search#index'
  get '/download_courier_report', to: 'parcels#download_courier_report'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
