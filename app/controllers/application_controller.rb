class ApplicationController < ActionController::Base
  devise_group :user, contains: [:student, :teacher]
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action -> { flash.discard }



  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uniID])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :uniID])
  end

  def json_to_database

    # CHANGE TO GET FROM USER
    access_token = "7036~1Zqk4k0rh1nxLirHTdH8Vbrw55twnvPp0MNBh2954EtITlQAU80JQPeniKXFK7tm"

    res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses?per_page=50", {:Authorization => "Bearer #{access_token}"}
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

    #for each course in json
    courses.each do |c|
      if c["enrollment_term_id"] == eti
        # Print course name
        puts "name: #{c["name"]}"

        #check course is in database
        if not Course.exists?(name: c["name"])
          #doesnt exist
          @course = Course.new(name: c["name"])
        end

        # get assignmnets for the course
        res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{c["id"]}/assignments?per_page=40", {:Authorization => "Bearer #{access_token}"}
        assignments = JSON.parse(res.body)

        #get submissions
        res = RestClient.get "https://myuni.adelaide.edu.au/api/v1/courses/#{c["id"]}/students/submissions?per_page=40", {:Authorization => "Bearer #{access_token}"}
        submissions = JSON.parse(res.body)

        #for each assignment in json, do work on submission
        assignments.each_with_index do |a|
          print "    #{a["name"]}, "

          #check assessment is in database
          if not Assessment.exists?(name: a["name"])
            #doesnt exist
            @assessment = Assessment.new(name: a["name"])
          end

          # get submission grade
          pos = submissions.find_index {|e| e["assignment_id"] == a["id"]}
          print "grade: #{submissions[pos]["score"]}/#{a["points_possible"]}"
          puts
        end
      end
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
