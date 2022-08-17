Feature:
  As a teacher
  I would like to be able to create courses
  so that I can organise sets of students into class groups
  and easily mark my students.

Background: I am on the create course page
  Given I am on the home page
  When I click the link "Create Course"
  Then I should see the text "New course"

# Happy path:
Scenario: Creating a course as a teacher
  Given I have entered class name "sample class"
  When I click the button "Create Course"
  Then I should see the text "Course was successfully created."

# Sad path:
Scenario: Creating a course as a teacher without inputting course details
  When I click the button "Create Course"
  Then I should see the text "Name can't be blank"