When(/^they enter their details "([^"]*)" "([^"]*)"$/) do |arg1, arg2|
  fill_in 'login_email', with: arg1
  fill_in 'login_password', with: arg2
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