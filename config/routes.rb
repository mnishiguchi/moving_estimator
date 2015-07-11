Rails.application.routes.draw do

  resources :rooms, only: [:index, :crete, :update, :destroy]

  resources :movings  # ALL
  resources :moving_items, only: [:create, :update, :destroy]

  resources :todos, except: [:show]
  resources :ingredients, only: [:index, :update, :destroy]

  devise_for :users, controllers: { confirmations: 'confirmations' }
  resources  :users, only: [:index, :destroy]

  get  'contact'   => 'contacts#new'
  post 'contact'   => 'contacts#create'

  root 'static_pages#home'
end
