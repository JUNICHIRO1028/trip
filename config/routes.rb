Rails.application.routes.draw do

  root to: 'homes#top'

  get 'homes/about', to: 'homes#about', as: :about

  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  

  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update]

  resources :groups, only: [:new, :index, :show, :create, :edit, :update]

  get "search" => "searches#search"
end
