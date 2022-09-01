# GIVEN
Given(/^a User is not logged in$/) do
  visit root_path
  expect(page).to have_current_path("/authentication/login")
end

Given(/^a User is not logged in but has an account$/) do
  #do a whole account creation
  visit "index"
  expect(page).to have_current_path("/authentication/login")
  pending
end


When(/^they enter their details "([^"]*)" "([^"]*)"$/) do |arg1, arg2|
  fill_in 'email', with: arg1
  fill_in 'student[password]', with: arg2
end

And(/^click login$/) do
  click_button 'commit'
end

And(/^they navigate to the login page$/) do
  visit 'sign_in'
end

Then(/^they will be redirected to their courses home page$/) do
  # expect to see course information and grades here
end

And(/^they have an account using their email "([^"]*)"$/) do |arg|
  #When they enter their email "john.jenkins@adelaide.edu.au"
  #     And click next
  #     Then they will be redirected to the Teacher register page
  #     When they enter their details "John" "Jenkins" "a1111111" "P@ssword1" "P@ssword1"
  #     And click register
  #     Then they should be redirected to the home page
end

When(/^they enter their email "([^"]*)"$/) do |arg|
  fill_in 'email', with: arg
end

And(/^click next$/) do
  click_button 'commit'
end

Then(/^they should be redirected to the home page$/) do
  expect(page).to have_current_path('/')
end

And(/^they do not have an account using their email "([^"]*)"$/) do |arg|
  pending
end

And(/^click register$/) do
  click_button 'commit'
end

Then (/^they will be on the login page$/) do
  expect(page).to have_current_path("/authentication/login")
end