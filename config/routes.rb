Rails.application.routes.draw do

  resources :courses do
    resources :enrolments, only: %i[ new index create destroy ]
    resources :assessments, only: %i[ new index create destroy ]
  end

  resources :assessments do
    resources :grades, only: %i[ new index create destroy ], shallow: true
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: "home#index"

  devise_for :teachers


  devise_for :students, controllers:{
    registrations: 'students/registrations'
  }

=begin

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
