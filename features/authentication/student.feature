Feature:
  As a student
  I want to log into the application
  So that I can access courses and view my grades.

  Background:
    Given I am not logged in
    And I am on the home page
    And there is a student with email "will.craft@student.adelaide.edu.au" and password "BadPassword"

  Scenario: Student signing up
    When I enter my email "jane.jenkins@student.adelaide.edu.au"
    And I click the button "Next"
    Then I will be redirected to the Student register page
    When I enter my student details "Jane" "Jenkins" "a9999999" "P@ssword1"
    And I click the button "Sign up"
    Then I should be redirected to the home page

  Scenario: Student logging in
    When I enter my email "will.craft@student.adelaide.edu.au"
    And I click the button "Next"
    Then I will be redirected to the Student login page
    When I enter my student password: "BadPassword"
    And I click the button "Log in"
    Then I should be redirected to the home page
