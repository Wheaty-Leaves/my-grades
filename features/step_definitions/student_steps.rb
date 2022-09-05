Then(/^I will be redirected to the Sign Up page as a student$/) do
  expect(page).to have_field("student_uniID")
end

Then(/^I will be redirected to the Student login page$/) do
  expect(page).to have_current_path('/students/sign_in?email=will.craft%40student.adelaide.edu.au')
end

Then(/^I will be redirected to the Student register page$/) do
  expect(page).to have_current_path('/students/sign_up?email=jane.jenkins%40student.adelaide.edu.au')
end

When(/^I enter my student details "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/) do |arg1, arg2, arg3, arg4|
  fill_in 'student[first_name]', with: arg1
  fill_in 'student[last_name]', with: arg2
  fill_in 'student[uniID]', with: arg3
  fill_in 'student[password]', with: arg4
  fill_in 'student[password_confirmation]', with: arg4
end

When(/^I enter my student password: "([^"]*)"$/) do |arg|
  fill_in 'student[password]', with: arg
end

Given(/^there is a student with email "([^"]*)" and password "([^"]*)"$/) do |arg1, arg2|
  student = Student.new(
    first_name: "Will",
    last_name: "Craft",
    email: arg1,
    uniID: "a1766887",
    password: arg2)
  student.save
end