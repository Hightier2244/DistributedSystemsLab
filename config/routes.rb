Rails.application.routes.draw do
  root to: redirect('/api-docs')

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :items, only: [:index, :create, :show, :update, :destroy]
end