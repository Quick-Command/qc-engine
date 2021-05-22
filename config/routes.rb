Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/api/v1/incidents/:incident_id/contacts/:contact_id', to: 'api/v1/incident_contacts#assign_contact_to_incident'
  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:show, :create]
      resources :incidents, only: [:index, :create, :show, :update]
    end
  end
end
