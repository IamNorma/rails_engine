Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index]
      resources :merchants, only: [:index, :show, :create, :destroy]
    end
  end
end
