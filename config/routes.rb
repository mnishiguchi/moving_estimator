Rails.application.routes.draw do

  resources :movings  # ALL
  resources :moving_items, only: [:index, :create, :update, :destroy]
  resources :rooms,        only: [:index, :new, :create, :update, :destroy]
  resources :todos,        only: [:index, :create, :update, :destroy]
  resources :ingredients,  only: [:index, :new, :create, :edit, :update, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'
                                    # registrations: "registrations",
                                    # sessions:      "sessions",
                                    # confirmations: "confirmations",
                                    # passwords:     "passwords"
                                  }

  resources  :users, only: [:index, :destroy]

  get  'contact'   => 'contacts#new'
  post 'contact'   => 'contacts#create'

  root 'static_pages#home'
end
