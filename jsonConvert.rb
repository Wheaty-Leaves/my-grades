require "json"
require "rest-client"
require "date"

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


