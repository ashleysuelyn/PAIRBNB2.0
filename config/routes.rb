Rails.application.routes.draw do

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index" #or get '/' => "welcome#index" #go to homepage
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get "/admin/listings" => "admins#unverified_listings", as: "admin_listings"

  post "/listing/:id/verify" => "listings#verify", as: "verify"

  resources :listings 



end
