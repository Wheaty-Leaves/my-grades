Feature:
  As a teacher
  I would like to be able to create courses
  so that I can organise sets of students into class groups
  and easily mark my students.

#Background: I am signed in with username "Teacher" and password "P@ssword123"
Background: I am on the create course page
  Given I am on the home page
  When I click 'Create Course'
  Then I should be on the course page

# Happy path:
Scenario: Creating a course as a teacher
  Given I have entered class name "sample class"
  When I click "create course"
  Then I will be redirected to the course page

# Bad case:
Scenario: Creating a course as a teacher without inputting course details
  When I click "create course"
  Then I will be prompted to fill in missing entries