Rails.application.routes.draw do

  resources :courses do
    resources :enrolments, only: %i[ new index create destroy ] do
      resources :assessments, only: %i[ new index create show destroy ] do
        resources :grades, only: %i[ new index create destroy ]
      end
    end
  end

  post 'courses/:id', to: 'courses#claim_course'
  get 'my_courses', to: 'courses#my_courses'

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
