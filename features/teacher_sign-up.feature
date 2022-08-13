Feature:
  As a teacher
  I want to sign-up to the MyGrades application
  So that I can create assignments and release grades for my students

  Scenario:
    Given I, as a Teacher, with email teacher1@adelaide.edu.au, do not have a MyGrades account
    And I click Sign Up
    Then I will be redirected to the "Sign Up" page
    When I input my details "Teacher" "Smith" "a1234567" "teacher1@adelaide.edu.au" "Password!"
    Then I will click Sign Up, and will be logged in


