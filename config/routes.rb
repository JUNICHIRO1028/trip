Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :comments, only: [:index, :destroy]
    resources :post_images, only: [:index, :destroy]

  end

  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about
    resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      member do
        delete :hide, as: 'users_hide'
        get :favorites
      end
    end
    resources :groups, only: [:new, :index, :show, :create, :edit, :update]
    get "search" => "searches#search"
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions_#guest_sign_in'
  end

end
