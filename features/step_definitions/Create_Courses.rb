Then(/^I will be prompted to fill in missing entries$/) do
  page.should have_css('.flashnotice', text: "Failed")
end

When(/^I click "([^"]*)"$/) do |arg|
  click_button(arg)
end

Then(/^I will be on "([^"]*)"$/) do |arg|
  expect(page).has_link?(arg)
  page.should have_css('.flashnotice', text: "Successfully added course")
end

Given(/^I have entered class name "([^"]*)"$/) do |arg|
  fill_in 'class_name', with: arg
end