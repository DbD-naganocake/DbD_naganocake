Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :customers
  # 会員側のルーティング設定
  scope module: :public do
    root to: "homes#top"
    get 'homes/about'
    
    resources :items, only: [:index,:show]
    resources :customers, only: [:edit,:show]
    get 'customers/quit'
    resources :cart_items, only: [:index]
    resources :orders, only: [:new,:index,:show]
    resources :deliveries, only: [:index,:edit]
  end
  
  # 管理者側のルーティング設定
  namespace :admin do
    get 'homes/top'
    resources :items, only: [:new,:index,:show,:edit]
    resources :genres, only: [:index,:edit]
    resources :customers, only: [:index,:show,:edit]
    resources :orders, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
