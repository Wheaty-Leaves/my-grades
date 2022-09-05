Then(/^I will be redirected to the Sign Up page$/) do
  expect(page).to have_field("teacher_uniID")
end

Then(/^I will be redirected to the Teacher login page$/) do
  expect(page).to have_current_path('/teachers/sign_in?email=will.craft%40adelaide.edu.au')
end

Then(/^I will be redirected to the Teacher register page$/) do
  expect(page).to have_current_path('/teachers/sign_up?email=john.jenkins%40adelaide.edu.au')
end

When(/^I enter my teacher details "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/) do |arg1, arg2, arg3, arg4|
  fill_in 'teacher[first_name]', with: arg1
  fill_in 'teacher[last_name]', with: arg2
  fill_in 'teacher[uniID]', with: arg3
  fill_in 'teacher[password]', with: arg4
  fill_in 'teacher[password_confirmation]', with: arg4
end

When(/^I enter my teacher password: "([^"]*)"$/) do |arg|
  fill_in 'teacher[password]', with: arg
end

Given(/^there is a teacher with email "([^"]*)" and password "([^"]*)"$/) do |arg1, arg2|
  teacher = Teacher.new(
    first_name: "Will",
    last_name: "Smith",
    email: arg1,
    uniID: "a1766887",
    password: arg2)
  teacher.save
end