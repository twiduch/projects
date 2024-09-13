Rails.application.routes.draw do
  root "public#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :dashboard, only: [ :index ]
  resources :projects, only: [ :index ]

  mount ActionCable.server => "/cable"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
