class HomeController < ApplicationController
  devise_group :user, contains: [:student, :teacher]
  before_action :authenticate_user!

  # function to determine whether teacher or student is attempting to signup/login

  def index
    @teacher = current_user.first_name
    render "index"
  end

  private
  def authenticate_user!
    if !user_signed_in?
      redirect_to authentication_login_path
    end
  end
end


