Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top", as: "root"
  get "tutorial" => "homes#tutorial", as: "tutorial"

  resources :users, only:[:show, :edit, :update]

  get "group/:id/data" => "groups#data", as: "group_data"
  resources :groups do
    resources :group_members, only: [:create, :destroy, :index] do
      member do
        post :direct
      end
    end
    resources :entries, only: [:create, :index, :destroy]
    resources :targets, only: [:create, :edit, :update, :destroy]
    resources :group_messages, only: [:create, :destroy]
  end

  resources :targets, only: [:create, :edit, :update, :destroy] do
    resources :results, only: [:create, :edit, :update, :destroy]
  end

  resources :contacts, only: [:new, :create]
end
