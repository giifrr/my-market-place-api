# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      resources :tokens, only: %i[create]
      resources :products, only: %i[index show create update destroy]
      resources :orders, only: %i[index show create]
    end
  end
end
