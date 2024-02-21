Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post "registrationsSuperAdmin", to: "registrations#createSuperAdmin"

  post "registrationsAdmin", to: "registrations#createAdmin"

  post "registrationsParticipant", to: "registrations#createParticipant"

  post "sessions", to: "sessions#create"




  root to: "home#index"

end
