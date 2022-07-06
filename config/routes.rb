Rails.application.routes.draw do
  post '/callback', to: 'line_bot#callback'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root to: 'homes#index'

  resources :diaries, only: [:index]
end
