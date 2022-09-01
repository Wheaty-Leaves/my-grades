Given(/^I, as a Student, with email student1@student\.adelaide\.edu\.au, do not have a MyGrades account$/) do
  # navigate to the login page
  visit('/students/sign_in')
end

Then(/^I click Sign Up as a student$/) do
  click_button 'commit'
end

Then(/^I will be redirected to the Sign Up page as a student$/) do
  expect(page).to have_field("student_uniID")
end

When(/^I input my details "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" as a student$/) do |arg1, arg2, arg3, arg4, arg5, arg6|
  # students have "student" in their email
  # check if second character is a number, if so, invalid email
  fill_in 'student_first_name', with: arg1
  fill_in 'student_last_name', with: arg2
  fill_in 'student_uniID', with: arg3
  fill_in 'student_email', with: arg4
  fill_in 'student_password', with: arg5
  fill_in 'student_password_confirmation', with: arg6
end

When(/^I click the Sign Up button$/) do
  click_button 'commit'
end

Then(/^they will be redirected to the Student login page$/) do
  expect(page).to have_current_path('/students/sign_in?email=jane.jenkins%40student.adelaide.edu.au')
end

Then(/^they will be redirected to the Student register page$/) do
  expect(page).to have_current_path('/students/sign_up?email=jane.jenkins%40student.adelaide.edu.au')
end

When(/^the student enters their details "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/) do |arg1, arg2, arg3, arg4, arg5|
  fill_in 'student[first_name]', with: arg1
  fill_in 'student[last_name]', with: arg2
  fill_in 'student[uniID]', with: arg3
  fill_in 'student[password]', with: arg4
  fill_in 'student[password_confirmation]', with: arg5
end

When(/^the student enters their password "([^"]*)"$/) do |arg|
  fill_in 'student[password]', with: arg
end