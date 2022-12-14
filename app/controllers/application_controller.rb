class ApplicationController < ActionController::Base
  devise_group :user, contains: [:student, :teacher]
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action -> { flash.discard }
  helper_method :json_to_database


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uniID, :access_token])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :uniID])
  end

  def json_to_database
    puts "Running API calls!"
    # check if student or teacher is logged in
    puts "#{current_user}"
    if student_signed_in?
      current_datetime = DateTime.now.utc
      if current_user.last_canvas_request == nil or ((current_datetime - current_user.last_canvas_request)).to_i  > (10*60)
        puts "student"
        #---do the API calls---
        # set the response body to nil
        res = nil
        #---
        access_token = current_user.access_token
        #---
        res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses?per_page=50", {:Authorization => "Bearer #{access_token}"}
        puts "courses request sent"
        data = JSON.parse(res.body)
        # gets the date of today
        current_date = Date.today
        current_user.last_canvas_request = current_datetime
        current_user.save
        # sets the time period to a year before
        period = (current_date - 365)
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
              #puts "Course.new(name: #{c["name"]}, canvas_id: #{c["id"]}, uuid: #{c["uuid"]}), enrollment_term_id: #{c["enrollment_term_id"]}"
              course = Course.create(name: c["name"], canvas_id: c["id"], uuid: c["uuid"], enrollment_term_id: c["enrollment_term_id"])
              Enrolment.create(student_id: current_user.id, course_id: course.id)
            else
              puts "Course found: #{c["name"]}"
              course = Course.find_by(canvas_id: c["id"])
              if not Enrolment.exists?(student_id: current_user.id, course_id: course.id)
                Enrolment.create(student_id: current_user.id, course_id: course.id)
              end
            end

            # get assignmnets for the course
            res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{course.canvas_id}/assignments?per_page=40", {:Authorization => "Bearer #{access_token}"}
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
                assessment = Assessment.create(course_id: course.id,canvas_id: a["id"], name: a["name"], max_score: a["points_possible"].to_f, due_date: a["due_at"], release_date: a["unlock_at"], canvas_course_id: a["course_id"])
              else
                puts "Found #{a["name"]}"
                assessment = Assessment.find_by(canvas_id: a["id"])
              end

              # get submission grade
              # change a["id"] to assessment.canvas_id
              pos = submissions.find_index {|s| s["assignment_id"] == a["id"]}
              puts "grade: #{submissions[pos]["score"]}/#{a["points_possible"]}"
              score = submissions[pos]["score"]
              if not Grade.exists?(canvas_student_id: submissions[pos]["user_id"] ,canvas_id: submissions[pos]["id"], canvas_assignment_id: a["id"], graded_at: submissions[pos]["graded_at"])
                # if there is no grade that exists with the same canvas id and graded_at date
                # create a new grade
                puts "Grade.new(student: student, assessment_id: assessment.id, score: #{submissions[pos]["score"]}, canvas_student_id: #{submissions[pos]["user_id"]}, canvas_id: #{submissions[pos]["id"]}, canvas_assignment_id: #{submissions[pos]["assignment_id"]}, graded_at: #{submissions[pos]["graded_at"]})"
                @grade = Grade.create(student_id: current_user.id, assessment_id: assessment.id, score: submissions[pos]["score"], canvas_student_id: submissions[pos]["user_id"], canvas_id: submissions[pos]["id"], canvas_assignment_id: submissions[pos]["assignment_id"], graded_at: submissions[pos]["graded_at"])
              else
                puts "Grade already exists and has not been updated"
              end
            end
          end
        end
      end
      puts "No API call needed"
    else
      # teacher signed in, no need to make API calls
      puts "Teacher signed in, no API calls needed"
    end
  end
end
