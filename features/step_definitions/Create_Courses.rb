Then(/^I will be prompted to fill in missing entries$/) do
  page.should have_css('.flashnotice', text: "Failed")
end

When(/^I click the link "([^"]*)"$/) do |arg|
  click_link(arg)
end

When(/^I click the button "([^"]*)"$/) do |arg|
  click_button(arg)
end

Then(/^I will be on "([^"]*)"$/) do |arg|
  expect(subject).to render_template("courses/new")
end

Given(/^I have entered class name "([^"]*)"$/) do |arg|
  fill_in 'course_name', with: arg
end

Then(/^I should see the text "([^"]*)"$/) do |notice|
  expect(page).to have_content(notice)
end