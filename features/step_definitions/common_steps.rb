Before do
  load Rails.root.join('db', 'seeds.rb')
end

When(/^I go to the home page$/) do
  visit '/'
end

When(/^I click on "(.*?)"$/) do |arg1|
  click_on arg1
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I fill the sign up form with "(.*?)" and "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see a text area containing "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I replace "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When(/^I click "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the word "(.*?)" should be highlighted$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
