Rails.application.routes.draw do

  resources :ingredients,  only: [:index, :new, :create, :edit, :update, :destroy]
  resources :movings  # ALL
  resources :moving_items, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :rooms,        only: [:index, :new, :create, :update, :destroy]
  resources :social_profiles, only: :destroy
  resources :todos,        only: [:index, :create, :update, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
                                    registrations: "registrations",
                                    confirmations: "confirmations" }
  resources  :users, only: [:index, :destroy]
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  # get  'dashboard' => 'movings#index'
  get  'contact'   => 'contacts#new'
  post 'contact'   => 'contacts#create'

  root 'static_pages#home'
end
