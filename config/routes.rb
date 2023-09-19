Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

namespace :admin do

    get "/" => "homes#top"

    resources :customers, only: [:index, :show, :edit, :update, :destroy] do
       member do
      get 'recipes'
      end
    end

    resources :genres, only: [:index, :edit, :create, :update, :destroy]

    resources :recipes, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
    get "/search" => "recipes#search"
  end

scope module: :public do

    get "/customers/check" => "customers#check"
    patch "/customers/withdraw" => "customers#withdraw"
    resources :customers, only: [:show, :update, :edit, :index]
    resources :genres, only: [:show]
    resources :recipes, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    
 

    root "homes#top"
    get "/about" => "homes#about"
    get "/search/:genre_id" => "recipes#search", as: :search
  end
  
  


end
