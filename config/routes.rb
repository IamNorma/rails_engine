Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'items#index'
      end
      namespace :items do
        get '/:id/merchants', to: 'merchants#show'
      end
      resources :items, only: [:index]
      resources :merchants
    end
  end
end
