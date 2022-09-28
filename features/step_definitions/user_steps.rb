# GIVEN
Given(/^I am not logged in$/) do
  visit root_path
  expect(page).to have_current_path("/authentication/login")
end

When(/^I enter my email "([^"]*)"$/) do |arg|
  fill_in 'email', with: arg
end

Then(/^I should be redirected to the home page$/) do
  expect(page).to have_current_path('/')
end