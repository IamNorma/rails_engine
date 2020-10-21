Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
      resources :items, only: [:index]
      resources :merchants
    end
  end
end
