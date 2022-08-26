class ApplicationController < ActionController::Base
  devise_group :user, contains: [:student, :teacher]
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action -> { flash.discard }



  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uniID])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :uniID])
  end




end
