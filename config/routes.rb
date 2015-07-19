Rails.application.routes.draw do
  root to: redirect('/offer')

  get 'offer', to: 'listings#new'

  # devise_for :growers
    post 'items', to: 'items#create'
  # devise_for :chefs
end
