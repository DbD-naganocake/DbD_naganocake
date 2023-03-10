Rails.application.routes.draw do


  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }


  # 会員側のルーティング設定
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"

    resources :items, only: [:index,:show]
    # resources :customers, only: [:edit,:show] 今回はいらない　アンスクライブをクワイトに統一
    get "/customers/my_page" => "customers#show"
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/quit' => 'customers#quit'
    patch 'customers/withdraw' => 'customers#withdraw'

    resources :cart_items do
      member do
        delete "destroy_all"
      end
    end
    get "/orders/complete" => "orders#complete"
    resources :orders, only: [:new,:index,:show,:create]
    post "/orders/confirm" => "orders#confirm"
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
  end

  # 管理者側のルーティング設定
  namespace :admin do
    get "" => "orders#index"

    resources :items, only: [:new,:index,:create,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders, only: [:show, :update]
    resources :order_details, only:[:update]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
  # get 'url' => 'コントローラー名#アクション名'
  #1. ユーザーがRailsアプリケーションのURLにアクセスする
  #2. そのURLに対応したコントローラとアクションを呼び出す
  #3. そのアクションに対応したビューを表示する
  #  syntax error 大体endが足りない,カンマがない　全角