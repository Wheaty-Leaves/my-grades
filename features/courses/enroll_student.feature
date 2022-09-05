Feature:
  As a teacher
  I would like to be able to add students to courses
  so that I can
  keep track of which students are in my courses.
  keep track of their estimated grades,
  and check that a student has been graded.

  Background:
    Given I am logged in as a teacher
    And there exists a student with first_name: "Jerry", last_name: "Smith", and student_id: "a1766887"

#  Happy
  Scenario:
    Given I am on the home page
