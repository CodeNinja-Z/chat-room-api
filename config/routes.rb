Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forums do
        resources :comments, only: %i[create update destroy]
      end
    end
  end
  root "api/v1/forums#index"
end
