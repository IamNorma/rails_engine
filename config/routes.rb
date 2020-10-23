Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'merchant_items#index'
        get '/:id/revenue', to: 'merchant_revenue#index'
      end
      namespace :items do
        get '/:id/merchants', to: 'merchants#show'
        get '/find', to: 'search#show'
      end
      resources :revenue, only: [:index]
      resources :items
      resources :merchants
    end
  end
end
