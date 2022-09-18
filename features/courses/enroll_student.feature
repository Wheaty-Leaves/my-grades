Feature:
  As a teacher
  I would like to be able to add students to courses
  so that I can
  keep track of which students are in my courses.
  keep track of their estimated grades,
  and check that a student has been graded.

  Background:
    Given I am logged in as a teacher
    And I am on the home page
    When I click the button "Create Course"
    Given I have entered class name "sample class"
    When I click the button "Create Course"

#  Happy Path
  Scenario:
    Given there exists a student with first_name: "A", last_name: "A", and student_id: "a1111111"
    And I click the button "View students"
    And I click the link "New enrolment"
    When I click the button "Create Enrolment"
    Then I should see the text "a1111111"