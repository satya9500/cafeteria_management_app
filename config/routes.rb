Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "home#index"
  get "/main", to: "main#index"
  post "/add_item_to_order", to: "orders#storeItems"
  get "/order/all", to: "orders#ordersAll", as: :orders_all
  get "/report", to: "reports#index", as: :reports
  get "/report/order/:order_id", to: "reports#order_details", as: :reports_order_details
  get "/report/query", to: "reports#range_query_report", as: :reports_range_query
  get "/register/clerk", to: "users#createClerkPage", as: :register_clerk_page
  post "/register/clerk", to: "users#createClerk", as: :register_clerk
  get "/register/owner", to: "users#createOwnerPage", as: :register_owner_page
  post "/register/owner", to: "users#createOwner", as: :register_owner

  resources :users
  resources :menu_items
  resources :menus
  resources :orders

  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session
end
