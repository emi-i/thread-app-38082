Rails.application.routes.draw do
  ddevise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'homes#index'
end
