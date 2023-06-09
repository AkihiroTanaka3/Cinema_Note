Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admins/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # 管理者
  namespace :admin do
    root to: 'homes#top'
    resources :movies, only: [:index, :show, :create, :destroy,]
    resources :users, only: [:index, :edit, :show, :update]
    resources :cinemas, only: [:show, :destroy]
    resources :reviews, only: [:destroy]
  end

  # ユーザー
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get '/users/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdraw', to: 'users#withdraw', as: 'withdraw'
      resources :users, only: [:show, :edit, :update]do
      member do 
        get 'likes'
      end
    end
    resources :movies, only: [:index, :show, :create, :destroy] do
      delete '/reviews/:review_id', to: 'movies#destroy', as: "destroy"
      post '/reviews', to: 'movies#create'
      resource :likes, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
