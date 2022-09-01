Feature:
  As a user (teacher or student)
  I want to log into the application
  So that I can either access courses and grades or view grades as a teacher or student respectively

  Scenario: Teacher Login
    Given a User is not logged in
    #And they have an account using their email "john.doe@adelaide.edu.au"
    When they enter their email "john.jenkins@adelaide.edu.au"
    And click next
    Then they will be redirected to the Teacher register page
    When the teacher enters their details "John" "Jenkins" "a1111111" "P@ssword1" "P@ssword1"
    And click register
    Then they should be redirected to the home page
    When I click the link "Logout"
    When they enter their email "john.jenkins@adelaide.edu.au"
    And click next
    Then they will be redirected to the Teacher login page
    When the teacher enters their password "P@ssword1"
    And click login
    Then they should be redirected to the home page

  Scenario: Student Login
    Given a User is not logged in
    #And they have an account using their email "jane.doe@student.adelaide.edu.au"
    When they enter their email "jane.jenkins@student.adelaide.edu.au"
    And click next
    Then they will be redirected to the Student register page
    When the student enters their details "Jane" "Jenkins" "a1111111" "P@ssword1" "P@ssword1"
    And click register
    Then they should be redirected to the home page
    When I click the link "Logout"
    Then they will be on the login page
    When they enter their email "jane.jenkins@student.adelaide.edu.au"
    And click next
    Then they will be redirected to the Student login page
    When the student enters their password "P@ssword1"
    And click login
    Then they should be redirected to the home page


  Scenario: Teacher Register
    Given a User is not logged in
    #And they do not have an account using their email "john.jenkins@adelaide.edu.au"
    When they enter their email "john.jenkins@adelaide.edu.au"
    And click next
    Then they will be redirected to the Teacher register page
    When the teacher enters their details "John" "Jenkins" "a1111111" "P@ssword1" "P@ssword1"
    And click register
    Then they should be redirected to the home page

  Scenario: Student Register
    Given a User is not logged in
    #And they do not have an account using their email "jane.jenkins@student.adelaide.edu.au"
    When they enter their email "jane.jenkins@student.adelaide.edu.au"
    And click next
    Then they will be redirected to the Student register page
    When the student enters their details "Jane" "Jenkins" "a9999999" "P@ssword1" "P@ssword1"
    And click register
    Then they should be redirected to the home page