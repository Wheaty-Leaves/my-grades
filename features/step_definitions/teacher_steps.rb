Given(/^I, as a Teacher, with email teacher1@adelaide\.edu\.au, do not have a MyGrades account$/) do
  # navigate to the login page
  visit("/login")
end

And(/^I click Sign Up$/) do
  click_link("Sign Up")
end

Then(/^I will be redirected to the "([^"]*)" page$/) do |arg|
  expect(page).to have_content(arg)
end

When(/^I input my details "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/) do |arg1, arg2, arg3, arg4, arg5|
  # students have "student" in their email
  # check if second character is a number, if so, invalid email
  fill_in 'signup_first_name', with: arg1
  fill_in 'signup_last_name', with: arg2
  fill_in 'signup_uniID', with: arg3
  fill_in 'signup_email', with: arg4
  fill_in 'signup_password', with: arg5
end

Then(/^I will click Sign Up, and will be logged in$/) do
  click_button 'Sign Up'
end