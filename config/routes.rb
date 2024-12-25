Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about
    resources :post_images, only: [:new, :create, :index, :show, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]
    resources :groups, only: [:new, :index, :show, :create, :edit, :update]
    get "search" => "searches#search"
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions_#guest_sign_in'
  end

end
