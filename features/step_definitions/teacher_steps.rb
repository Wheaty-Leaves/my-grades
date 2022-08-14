Given(/^I, as a Teacher, with email teacher1@adelaide\.edu\.au, do not have a MyGrades account$/) do
  # navigate to the login page
  visit("/teachers/sign_in")
end

And(/^I click Sign Up$/) do
  find("a[href='/teachers/sign_up']").click
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

Then(/^I will click Sign Up, and will be logged in$/) do
  click_button 'commit'
end