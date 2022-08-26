Feature:
  As a user (teacher or student)
  I want to log into the application
  So that I can either access courses and grades or view grades as a teacher or student respectively

  Scenario: First time login teacher
    Given a teacher has not logged in
    And they navigate to the login page
    When they enter their details "teacher1@adelaide.edu.au" "Password!"
    And click login
    Then they will be redirected to their courses home page

  Scenario: First time login student
    Given a student has not logged in
    And they navigate to the login page
    When they enter their details "student1@student.adelaide.edu.au" "Password!"
    And click login
    Then they will be redirected to their courses home page