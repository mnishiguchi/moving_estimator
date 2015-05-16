Rails.application.routes.draw do

  resources :contacts, only: [:new, :create]

  devise_for :users
  root 'static_pages#home'
end
