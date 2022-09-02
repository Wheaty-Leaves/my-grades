Feature:
  As a teacher
  I would like to be able to create courses
  so that I can organise sets of students into class groups
  and easily mark my students.

Background: I am on the create course page
  Given a User is not logged in
  When they enter their email "john.jenkins@adelaide.edu.au"
  And click next
  Then they will be redirected to the Teacher register page
  When the teacher enters their details "John" "Jenkins" "a1111111" "P@ssword1" "P@ssword1"
  And click register
  Then they should be redirected to the home page
  When I click the button "Create Course"
  Then I should see the text "New course"

# Happy path:
Scenario: Creating a course as a teacher
  Given I have entered class name "sample class"
  When I click the button "Create Course"
  Then I should see the text "sample class"
  Then I should see the text "Teacher: John Jenkins"

# Sad paths:
Scenario: Creating a course as a teacher without inputting course details
  When I click the button "Create Course"
  Then I should see the text "Name can't be blank"

Scenario: I attempt to create a course while not signed in
  Given I am on the home page
  And I click the link "Logout"
  When I go to the create courses page
  Then I should see the text "You need to sign in or sign up before continuing."
  
Scenario: I attempt to create a course while signed in a student
  Given I am on the home page
  When I click the link "Logout"
  And they enter their email "jane.jenkins@student.adelaide.edu.au"
  And I click the button "Next"
  And the student enters their details "Jane" "Jenkins" "a1111111" "P@ssword1" "P@ssword1"
  And I click the button "Sign up"
  And I go to the create courses page
  Then I should see the text "You need to sign in or sign up before continuing."