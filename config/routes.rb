# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :groups, only: [:index, :new, :create] do
    resources :expenses, only: [:index, :new, :create]
  end

  authenticated :user do
    root "groups#index", as: :authenticated_root
  end
  unauthenticated :user do
    root 'groups#login_page', as: :unauthenticated_root
  end
end
