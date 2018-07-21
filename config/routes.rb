Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :tv_shows, only: [:index] do
      member do
        post :add_to_watchlist
        post :remove_from_watchlist
        post :add_to_favorite
        post :remove_from_favorite
      end
    end
  end
end
