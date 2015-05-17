Rails.application.routes.draw do

  # resources :contacts, only: [:new, :create]
  get  'contact' => 'contacts#new'
  post 'contact' => 'contacts#create'

  devise_for :users
  root 'static_pages#home'
end
