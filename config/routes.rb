Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admins/sessions"
  }

  # ユーザー
  scope module: :public do
    root to: 'homes#top'
    resources :user, only: [:show, :edit]
    resources :movies, only: [:index, :show, :create, :destroy] do
      delete '/reviews/:review_id', to: 'movies#destroy', as: "destroy"
      post '/reviews', to: 'movies#create'
    end
  end

  # 管理者
  namespace :admin do
    root to: 'homes#top'
    resources :movies, only: [:index, :new, :show, :edit, :create, :destroy, :upodate]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :users, only: [:index, :edit, :show, :update]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
