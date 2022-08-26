class AuthenticationsController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping
  # this is the sign in route for signing in. It will send
  # the appropriate data to either the teacher or student controller to log in

  def new
    if student_signed_in?
      puts "student signed in"
    end
    if teacher_signed_in?
      puts "teacher signed in"
    end
    render "authentication/login"
  end

  def create
    # checks email to ensure it is a valid uni email
    @email = check_email(params[:email])
    if @email != nil
      # checks database to ensure that the user exists
      # if does exist, redirect to specific session form
      # else provide a notice and redirect to sign up
      # student exists
      if @email == "student"
        if Student.exists?(email: params[:email])
          #authenticate_user! :student
          redirect_to new_student_session_path(:email => params[:email])
        else
          redirect_to new_student_registration_path(:email => params[:email])
        end
      elsif @email == "teacher"
        if Teacher.exists?(email: params[:email])
          #authenticate_user! :student
          redirect_to new_teacher_session_path(:email => params[:email])
        else
          redirect_to new_teacher_registration_path(:email => params[:email])
        end
      end
    else
      flash[:alert] = "invalid email address"
    end
  end

  def logout
    puts current_user :student
    # determine what user is logged in, then do
    if current_user :student
      @email = "student"
      puts "EXECUTING STUDENT SESSION"
      redirect_to destroy_student_session_path, method: :delete, notice: "Logged Out Successfully"
    elsif current_user :teacher
      @email = "teacher"
      puts "EXECUTING TEACHER SESSION"
      redirect_to destroy_teacher_session_path, method: :delete, notice: "Logged Out Successfully"
    else
      puts "NO SESSION EXECUTION"
    end
  end

  protected
  def resource_name
    if @email == "student"
      :student
    else
      :teacher
    end
  end

  def resource
    if @email == "student"
      @resource ||= Student.new
    else
      @resource ||= Teacher.new
    end
  end

  def devise_mapping
    if @email == "student"
      @devise_mapping ||= Devise.mappings[:student]
    else
      @devise_mapping ||= Devise.mappings[:teacher]
    end
  end


  private
  def check_email(email)
    if email.match(/([a-z]+\.[a-z]+)@student.adelaide.edu.au/)
      # if email has ********@student.adelaide.edu.au
      # then sign in as student
      params[:type] = "student"
      puts "Student"
      return "student"
    elsif email.match(/([a-z]+\.[a-z]+)@adelaide.edu.au/)
      # else
      # sign in as teacher
      params[:type ] = "teacher"
      return "teacher"
    else
      return nil
    end
  end


end