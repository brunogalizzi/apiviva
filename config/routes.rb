Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :properties
  get :atualizar, to: 'properties#atualizar'
  root to: 'properties#index'
end
