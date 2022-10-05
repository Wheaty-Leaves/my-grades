class ApplicationController < ActionController::Base
  devise_group :user, contains: [:student, :teacher]
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action -> { flash.discard }
  helper_method :json_to_database


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uniID])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :uniID])
  end

  def json_to_database
    puts "Running API calls!"
    # check if student or teacher is logged in
    puts "#{current_user}"
    if current_user :student
      puts "student"
      #---do the API calls---
      # retrieve data form access toke, as of branch (json_to_database_converter) access_token not implemented
      # set the response body to nil
      res = nil
      # will change this to access_token = current_user.access_token
      # Chris' access token
      access_token = "7036~1Zqk4k0rh1nxLirHTdH8Vbrw55twnvPp0MNBh2954EtITlQAU80JQPeniKXFK7tm"
      #---
      # access_token = current_user.access_token
      #---
      res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses?per_page=50", {:Authorization => "Bearer #{access_token}"}
      puts "courses request sent"
      data = JSON.parse(res.body)
      # gets the date of today
      now = Date.today
      # sets the time period to a year before
      period = (now - 365)
      # enrollment term id
      eti = 0
      courses = []
      # gets the most recent enrollment term id
      data.each do |d|
        if d["created_at"] == nil
          # if created at is nil, skip as it throws an error
        elsif DateTime.parse(d["created_at"]).to_date > period
          if d["enrollment_term_id"] >= eti
            eti = d["enrollment_term_id"]
            courses << d
          end
        end
      end

      courses.to_json

      #for each course in json
      courses.each do |c|
        if c["enrollment_term_id"] == eti
          # Print course name

          #check course is in database
          if not Course.exists?(canvas_id: c["id"])
            #doesnt exist
            puts "Course.new(name: #{c["name"]}, canvas_id: #{c["id"]}, uuid: #{c["uuid"]}), enrollment_term_id: #{c["enrollment_term_id"]}"
            #course = Course.new(name: c["name"], canvas_id: c["id"])
          else
            puts "Course found: #{c["name"]}"
            #course = Course.find_by(course_id: c["id"])
          end

          # get assignmnets for the course
          res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{c["id"]}/assignments?per_page=40", {:Authorization => "Bearer #{access_token}"}
          # res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{course.canvas_id}/assignments?per_page=40", {:Authorization => "Bearer #{access_token}"}
          assignments = JSON.parse(res.body)

          #get submissions
          res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{c["id"]}/students/submissions?per_page=40", {:Authorization => "Bearer #{access_token}"}
          # res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{course.canvas_id}/students/submissions?per_page=40", {:Authorization => "Bearer #{access_token}"}
          submissions = JSON.parse(res.body)

          #for each assignment in json, do work on submission
          assignments.each_with_index do |a|

            #check assessment is in database
            if not Assessment.exists?(canvas_id: a["id"])
              #doesnt exist
              puts "Creating Assessment: Assessment.new(canvas_id: #{a["id"]}, name: #{a["name"]}, max_score: #{a["points_possible"]}, due_date: #{a["due_at"]}, release_date: #{a["unlock_at"]}, canvas_course_id: #{a["course_id"]})"
              #assessment = Assessment.new(canvas_id: a["id"], name: a["name"], max_score: a["points_possible"], due_date: a["due_at"], release_date: a["unlock_at"], canvas_course_id: a["course_id"])
            else
              puts "Found #{a["name"]}"
              #assessment = Assessment.find_by(canvas_id: a["id"])
            end

            # get submission grade
            # change a["id"] to assessment.canvas_id
            pos = submissions.find_index {|s| s["assignment_id"] == a["id"]}
            puts "grade: #{submissions[pos]["score"]}/#{a["points_possible"]}"
            score = submissions[pos]["score"]
            student = Student.find_by uniID: current_user.uniID
            if not Grade.exists?(canvas_student_id: submissions[pos]["user_id"] ,canvas_id: submissions[pos]["id"], canvas_assignment_id: a["id"], graded_at: submissions[pos]["graded_at"])
              # if there is no grade that exists with the same canvas id and graded_at date
              # create a new grade
              puts "Grade.new(student: student, assessment_id: assessment.id, score: #{submissions[pos]["score"]}, canvas_student_id: #{submissions[pos]["user_id"]}, canvas_id: #{submissions[pos]["id"]}, canvas_assignment_id: #{submissions[pos]["assignment_id"]})"
            else
              puts "Grade already exists and has not been updated"
            end
            #@grade = Grade.new(student_id: current_user.uniID, assessment: assessment, name: a["name"], score: score)
          end
        end
      end

    else
      # teacher signed in, no need to make API calls
      puts "Teacher signed in, no API calls needed"
    end




=begin
    courses.to_json

    # Print course name

    # print assignment name, submission grade, assignment points possible

    courses.each do |c|
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
=end

  end
end
