Rails.application.routes.draw do

  resources :courses do
    resources :enrolments, only: %i[ new index create destroy ] do
      resources :grades, only: %i[ new index create destroy ]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: "home#index"

  devise_for :students, :teachers

=begin
  devise_for :students, controllers:{
    sessions: 'students/sessions',
    registrations: 'students/registrations'
  }
  devise_for :teachers, controllers:{
    sessions: 'teachers/sessions',
    registrations: 'teachers/registrations'
  }
=end
  # get the sign in page
  get 'authentication/login', to: 'authentications#new'
  post 'authentication/login', to: 'authentications#create'
  get 'authentication/logout', to: 'authentications#logout'
end
