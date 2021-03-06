Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations",
    omniauth_callbacks: "omniauth_callbacks"
  }

  resources :games do
    member do
      get :confirm_destroy
      get :images
      get :zip
      get :executable
      get :keys
      put :save_keys
      get :checklist
      put :publish

      get :stats
      get :scores
    end
  end

  resources :images, only: [:create, :update, :destroy]
  resources :game_zips, only: [:create, :update] do
    member do
      get :root_files
    end
  end

  resources :arcade_machines do
    collection do
      get "map" => "arcade_machines#map", as: :map
      get :all_subscriptions
    end

    member do
      get :confirm_destroy
      get :images
      get :stats

      resources :approval_requests, only: [:new, :update, :show], controller: :approval_requests
    end
  end

  resources :playlists do
    collection do
      get :all_listings
    end

    member do
      get :confirm_destroy
    end
  end

  resources :listings, only: [:create, :destroy]
  resources :subscriptions, only: [:create, :destroy]
  resources :users, only: [:show]

  resources :comments, only: [:create, :destroy]

  resources :key_maps, only: [:index]

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :playlists, only: [:index]
      resources :plays, only: [:create] do
        collection do
          post :start
        end

        member do
          put  :stop
        end
      end

      resources :high_scores, only: [:index, :create]
    end
  end

  namespace :admin do
    resources :users, ony: [:index, :edit, :update]
    resources :approval_requests, only: [:index, :edit, :update]
  end

  get "/json_generator", controller: :metadata_json_generator, action: :new
  post "/json_generator", controller: :metadata_json_generator, action: :create

  get "/search" => "search#index", as: :search
  get "/feedback" => "pages#feedback", as: :feedback
  get "/contact" => "pages#feedback", as: :contact
  get "/dash" => "pages#dash", as: :dash
  get "/terms" => "pages#terms", as: :terms
  root "pages#index"
end
