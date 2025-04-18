Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :v1 do
    resources :items, only: [:index, :create, :show, :update, :destroy]
  end
end
