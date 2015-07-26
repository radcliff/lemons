Rails.application.routes.draw do
  root to: redirect('/offer')

  get 'offer', to: 'listings#form'

  namespace :api, defaults: { format: :json } do
    devise_scope :growers do
      post 'growers', to: 'growers#create'
    end

    post 'sessions', to: 'sessions#create'
    # delete 'sessions/:id', to: 'sessions#destroy'

    post 'items', to: 'items#create'
  end

  devise_for :growers
  # devise_for :chefs
end
