Rails.application.routes.draw do

  root to: 'homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'homes/about', to: 'homes#about', as: :about

  devise_for :users

  resources :post_images, only: [:new, :create, :index, :show, :destroy]
    resources :post_comments, only: [:create, :destroy]
  resources :users, only: [:show, :edit, :update]
end
