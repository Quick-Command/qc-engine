Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:show, :create]
      resources :incidents, only: [:index, :create, :show, :update]
    end
  end
end
