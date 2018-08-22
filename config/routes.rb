Rails.application.routes.draw do
  resources :contracts
  resources :shares, only: :show
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root "contracts#index"
end
