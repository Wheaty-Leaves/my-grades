Given(/^I, as a Teacher, with email teacher1@adelaide\.edu\.au, do not have a MyGrades account$/) do
  # navigate to the login page
  visit("/teachers/sign_in")
end

Then(/^I click Sign Up as a teacher$/) do
  click_button 'commit'
end

Then(/^I will be redirected to the Sign Up page$/) do
  expect(page).to have_field("teacher_uniID")
end

When(/^I input my details "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/) do |arg1, arg2, arg3, arg4, arg5, arg6|
  # students have "student" in their email
  # check if second character is a number, if so, invalid email
  fill_in 'teacher_first_name', with: arg1
  fill_in 'teacher_last_name', with: arg2
  fill_in 'teacher_uniID', with: arg3
  fill_in 'teacher_email', with: arg4
  fill_in 'teacher_password', with: arg5
  fill_in 'teacher_password_confirmation', with: arg6
end

Then(/^they will be redirected to the Teacher login page$/) do
  expect(page).to have_current_path('/teachers/sign_in?email=john.jenkins%40adelaide.edu.au')
end

Then(/^they will be redirected to the Teacher register page$/) do
  expect(page).to have_current_path('/teachers/sign_up?email=john.jenkins%40adelaide.edu.au')
end

When(/^the teacher enters their details "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/) do |arg1, arg2, arg3, arg4, arg5|
  fill_in 'teacher[first_name]', with: arg1
  fill_in 'teacher[last_name]', with: arg2
  fill_in 'teacher[uniID]', with: arg3
  fill_in 'teacher[password]', with: arg4
  fill_in 'teacher[password_confirmation]', with: arg5
end

When(/^the teacher enters their password "([^"]*)"$/) do |arg|
  fill_in 'teacher[password]', with: arg
end