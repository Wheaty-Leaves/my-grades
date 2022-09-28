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
      puts "invalid email address"
      flash.alert = "Invalid email, email must not contain numbers, have an @student.adelaide.edu.au for students or an @adelaide.edu.au for teachers"
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
=begin
  #parse course from Json

  # if assignment exists
  # else create

  #add grade and connect to assignment

  def json_to_database
    #convert to ruby array
    @courses_json = JSON.parse(response.body)
    @assignments_json = JSON.parse(response.body)
    @submission_json = JSON.parse(response.body)

    @courses_json.each do |c|
      if c["enrollment_term_id"] == eti
        # Print course name
        puts "name: #{c["name"]}"
        # get assignmnets for the course
        res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{c["id"]}/assignments?per_page=40", {:Authorization => "Bearer #{access_token}"}
        assignments = JSON.parse(res.body)
        res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{c["id"]}/students/submissions?per_page=40", {:Authorization => "Bearer #{access_token}"}
        submissions = JSON.parse(res.body)
        assignments.each_with_index do |a|
          print "    #{a["name"]}, "
          # get submission grade
          pos = submissions.find_index {|e| e["assignment_id"] == a["id"]}
          print "grade: #{submissions[pos]["score"]}/#{a["points_possible"]}"
          puts
        end
      end
    end
=begin
    #for each course
    @courses_json.each do |n|
      @assessment = Assessment.find_by assessment_id: n[:id]
      #check if assignment exists in database
      if @assessment == nil
        @assessment = Assessment.new(assessment_id: n[:id])
      end

      @grade = @assessment.find_by student: n[:something]
      if @grade == nil
        @grade = Grade.new(something)
      end

        #save

    end
=end
  end