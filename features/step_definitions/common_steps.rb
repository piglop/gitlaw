# encoding: utf-8

Before do
  load Rails.root.join('db', 'seeds.rb')
end

When(/^I go to the home page$/) do
  visit '/'
end

When(/^I click (?:on )?"(.*?)"$/) do |arg1|
  click_on arg1
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content(arg1)
end

When(/^I fill the sign up form with "(.*?)" and "(.*?)"$/) do |arg1, arg2|
  fill_in "user_email", with: arg1
  fill_in "user_password", with: arg2
  fill_in "user_password_confirmation", with: arg2
  click_button "Créer le compte"
end

Then(/^I should see a text area containing "(.*?)"$/) do |arg1|
  find("textarea").should have_content(arg1)
end

When(/^I replace "(.*?)" with "(.*?)" in "(.*?)"$/) do |old_text, new_text, field|
  text = find_field(field).value
  text = text.sub(old_text, new_text)
  fill_in field, with: text
end

Then(/^the word "(.*?)" should be highlighted$/) do |arg1|
  all("strong").map(&:text).join(" ").should include(arg1)
end
