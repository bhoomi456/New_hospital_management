Rails.application.routes.draw do
  root "dashboards#index"

  get "/home", to: redirect("/")

  get "dashboard", to: "dashboards#index"
  get "dashboard/hospitals", to: "dashboards#hospitals"
  get "dashboard/doctors", to: "dashboards#doctors"
  get "dashboard/patients", to: "dashboards#patients"
  get "dashboard/appointments", to: "dashboards#appointments"
  get "dashboard/profiles", to: "dashboards#profiles"

  # scope module: :admin do
  #   resources :hospitals
  # end

  # namespace :admin do
  #   resources :hospitals
  # end


  resources :appointments do
    member do
      patch :cancel
    end

    collection do 
      get :upcoming
    end
  end

  # concern :searchable do
  #   collection do
  #     get :search
  #   end
  # end

  # resources :doctors, concerns: :searchable
  # resources :patients, concerns: :searchable

  # resources :doctors do
  #   resources :appointments
  # end

  resources :patients do
    collection do
      get :export
    end
  end

  # namespace :api do
  #   namespace :v1 do
  #     resources :patients do
  #       resources :appointments, shallow: true do
  #         member do
  #           patch :cancel
  #         end

  #         collection do
  #           get :upcoming
  #         end
  #       end
  #     end
  #   end
  # end

  # # resources :patients do
  # #   resources :appointments, shallow: true
  # # end
  resources :hospitals 
  resources :doctors
  resources :appointments
  resources :patients
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

end