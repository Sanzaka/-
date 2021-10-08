Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top", as: "root"
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'



  resources :users, only:[:show, :edit, :update] do
    post "all_create" => "targets#all_create"
  end
  get "search" => "searches#search"
  get "my_group" => "groups#my_group"
  get "quick_form" => "users#quick_form"
  
  resources :groups do
    resources :group_members, only: [:create, :destroy, :index] do
      member do
        post :direct
      end
    end
    resources :entries, only: [:create, :index, :destroy]
    resources :targets, only: [:create, :edit, :update, :destroy]
    resources :group_messages, only: [:create, :destroy]
    resources :stamps, only: [:create, :destroy]
  end

  resources :targets, only: [:create, :edit, :update, :destroy] do
    resources :results, only: [:create, :edit, :update, :destroy]
  end

  resources :contacts, only: [:new, :create]
end
