Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'confirmations' }
  resources  :users, only: [:index, :show, :destroy]
  get  'dashboard' => 'users#show'
  get  'about'     => 'static_pages#about'
  get  'contact'   => 'contacts#new'
  post 'contact'   => 'contacts#create'

  root 'static_pages#home'
end
