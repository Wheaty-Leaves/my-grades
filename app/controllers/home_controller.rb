class HomeController < ApplicationController
  devise_group :user, contains: [:student, :teacher]
  before_action :authenticate_user!

  # function to determine whether teacher or student is attempting to signup/login

  def index
    render "index"
  end

  private
  def authenticate_user!
    if !user_signed_in?
      redirect_to authentication_login_path
    end
  end
end
