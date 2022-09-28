Then(/^I will be prompted to fill in missing entries$/) do
  page.should have_css('.flashnotice', text: "Failed")
end

Given(/^I have entered class name "([^"]*)"$/) do |arg|
  fill_in 'course_name', with: arg
end

When(/^I go to the create courses page$/) do
  visit new_course_path
end