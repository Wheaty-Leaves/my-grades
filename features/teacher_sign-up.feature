Feature:
  As a teacher
  I want to sign-up to the MyGrades application
  So that I can create assignments and release grades for my students

  Scenario:
    Given I, as a Teacher, with email teacher1@adelaide.edu.au, do not have a MyGrades account
    And I click Sign Up as a teacher
    Then I will be redirected to the Sign Up page
    When I input my details "Teacher" "Smith" "a1234567" "teacher1@adelaide.edu.au" "Password!" "Password!"
    When I click the Sign Up button
    Then I should see the text "You have signed up successfully."


