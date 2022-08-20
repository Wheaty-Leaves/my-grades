Feature:
  As a Student
  I want to sign-up to the MyGrades application
  So that I can view my grades for each of my courses

  Scenario:
    Given I, as a Student, with email student1@student.adelaide.edu.au, do not have a MyGrades account
    And I click Sign Up as a student
    Then I will be redirected to the Sign Up page as a student
    When I input my details "Student" "Smith" "a2345678" "student1@student.adelaide.edu.au" "Password!" "Password!" as a student
    When I click the Sign Up button
    Then I should see the text "You have signed up successfully."

