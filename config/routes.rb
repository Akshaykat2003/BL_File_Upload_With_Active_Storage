Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Custom routes for user actions
      get  'users',          to: 'users#index'      # Get all users
      get  'users/:id',      to: 'users#show'       # Get a single user
      post 'users',          to: 'users#create'     # Create a user

      # Custom route for uploading profile pictures
      post 'users/:id/upload', to: 'users#upload_profile_picture'
    end
  end
end
