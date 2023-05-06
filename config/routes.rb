Rails.application.routes.draw do

  devise_for :admins
  devise_for :users

  scope module: :public do
    root to: 'homes#top'
    resources :movies, only: [:index, :show, :create, :destroy]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :movies, only: [:index, :show, :edit, :create, :destroy, :upodate]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :users, only: [:index, :edit, :show, :update]
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
