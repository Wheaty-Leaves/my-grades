When(/^I am on the home page$/) do
  visit root_path
end

Then(/^I should see the text "([^"]*)"$/) do |notice|
  expect(page).to have_content(notice)
end

When(/^I click the link "([^"]*)"$/) do |arg|
  click_link(arg)
end

When(/^I click the button "([^"]*)"$/) do |arg|
  click_button(arg)
end