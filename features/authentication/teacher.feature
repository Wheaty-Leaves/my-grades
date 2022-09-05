Feature:
  As a user teacher
  I want to log into the application
  So that I can either access/create courses,
  and view/edit my students grades.

  Background:
    Given I am not logged in
    And I am on the home page
    And there is a teacher with email "will.craft@adelaide.edu.au" and password "BadPassword"

  Scenario: Teacher Register
    When I enter my email "john.jenkins@adelaide.edu.au"
    And I click the button "Next"
    Then I will be redirected to the Teacher register page
    When I enter my teacher details "John" "Jenkins" "a1111111" "P@ssword1"
    And I click the button "Sign up"
    Then I should be redirected to the home page
    And I should see the text "John"

  Scenario: Teacher Login
    When I enter my email "will.craft@adelaide.edu.au"
    And I click the button "Next"
    Then I will be redirected to the Teacher login page
    When I enter my teacher password: "BadPassword"
    And I click the button "Log in"
    Then I should be redirected to the home page
    And I should see the text "Will"