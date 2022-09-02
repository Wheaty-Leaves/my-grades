When(/^I am on the home page$/) do
  visit root_path
end

When(/^I go to the create courses page$/) do
  visit new_course_path
end