Rails.application.routes.draw do
  scope "(:locale)", locale: /ja|en/ do
    devise_for :users
    root "static_pages#home"
    get "/zone_top_motel", to: "static_pages#zone_top_motel"
    resources :motels do
      resources :reviews
      post "/add_my_list" , to: "motels#add_my_list"
      post "/delete_my_list" , to: "motels#delete_my_list"
    end 
    resources :rooms
    resources :equipments
    resources :users, only: [:index, :show, :update] do
      member do
        resources :followings, only: [:index]
        resources :followers, only: [:index]
      end
    end
    post "/like", to: "reviews#like"
    get "/load_more", to: "motels#load_more"
    get "/search", to: "motels#search"
    resources :relationships, only: [:create, :destroy]
    resources :reviews do
      resources :comments
    end
    resources :comments do
      resources :replies
    end
    get "/my_list_hotel", to: "users#list_hotel"
    get 'searchs/index'

  end

end
