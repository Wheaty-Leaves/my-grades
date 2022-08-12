Feature:
  As a teacher
  I want to sign-up to the MyGrades application
  So that I can create assignments and release grades for my students

  Scenario:
    Given a Teacher does not have a MyGrades account
    And they click signup
    Then they will be redirected to the signup page
    When they input their details and click signup
    Then they will be logged in as a teacher
