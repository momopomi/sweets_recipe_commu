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
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    
    resources :recipes, only: [:index, :show, :edit, :update]
    resources :comments, only: [:destroy]
    get "/search" => "items#search"
  end

scope module: :public do
    get "/customers/check" => "customers#check"
    patch "/customers/withdraw" => "customers#withdraw"
    resource :customers, only: [:show, :update, :edit, :index]
    
    resources :recipes, only: [:new, :create, :show, :index, :edit, :update, :destroy]

    resources :res do   # posts に紐づかせるため、ネストにする 
    resources :comments, only: [:create, :destroy] 
    end

    root "homes#top"
    get "/about" => "homes#about"
    get "/search" => "items#search"
  end


end
