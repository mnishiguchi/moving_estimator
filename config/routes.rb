Rails.application.routes.draw do

  get 'users/index'

  # resources :contacts, only: [:new, :create]
  get  'contact' => 'contacts#new'
  post 'contact' => 'contacts#create'

  devise_for :users, controllers: { confirmations: 'confirmations' }
  get  'about'   => 'static_pages#about'
  root 'static_pages#home'
end
