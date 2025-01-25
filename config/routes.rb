Rails.application.routes.draw do
  # API namespace
  namespace :api do
    namespace :v1 do
      # Authentication routes
      namespace :auth do
        post :register, to: 'users#register'
        post :login, to: 'users#login'
        delete :logout, to: 'users#logout'
      end

      # User routes
      resources :users, only: [:show, :update]

      # Post routes
      resources :posts do
        # Comments nested under posts
        resources :comments, only: [:index, :create, :update, :destroy]
        # Search for posts
        get :search, on: :collection
      end

      # Tag routes
      resources :tags, only: [:index]
      get 'tags/:tag_id/posts', to: 'tags#posts_by_tag'
    end
  end

  # Health check route for the app
  get "up", to: "rails/health#show", as: :rails_health_check

  # Root route
  root to: redirect("/api/v1/posts")
end
