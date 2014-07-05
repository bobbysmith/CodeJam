Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # root to: "home#index"

  resources :users
  resources :songs, except: [:edit, :update, :destroy]


  CodeJam::Application.routes.draw do
    root to: "home#index"
    get "/auth/:provider/callback" => "sessions#create"
    get "/signout" => "sessions#destroy", :as => :signout
    get "/login", to: "users#login"
  end
end
