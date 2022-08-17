Rails.application.routes.draw do
  resources :courses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
#   root "courses#index"
  root to: "home#index"

  devise_for :teachers, controllers: {
    sessions: 'teachers/sessions'
  }

  devise_for :students, controllers: {
    sessions: 'students/sessions'
  }
end
