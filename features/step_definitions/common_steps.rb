# encoding: utf-8

Given(/^there's a user "(.*?)" with identifier "(.*?)"$/) do |arg1, identifier|
  User.seed(:name, name: arg1, slug: identifier)
end

Given(/^the text "(.*?)" is owned by user "(.*?)"$/) do |arg1, arg2|
  Text.where(title: arg1).first.update_attribute(:user_id, User.where(name: arg2).first.id)
end

Given(/^there's a text "(.*?)" with identifier "(.*?)" and the content of "(.*?)" owned by user "(.*?)"$/) do |arg1, identifier, arg2, user|
  Text.seed :title, title: arg1, slug: identifier, text: File.read(arg2), user_id: User.find(user).id
end

Given(/^the text "(.*?)" is featured$/) do |arg1|
  FeaturedText.seed :text_id, text_id: Text.find(arg1).id
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

When(/^I fill the sign up form with name "(.*?)", identifier "(.*?)", email "(.*?)" and password "(.*?)"$/) do |name, identifier, email, password|
  fill_in "user_name", with: name
  fill_in "user_slug", with: identifier
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  fill_in "user_password_confirmation", with: password
  click_button "Créer le compte"
end

Then(/^I should see a text area containing "(.*?)"$/) do |arg1|
  find("textarea").should have_content(arg1)
end

When(/^I replace "(.*?)" with "(.*?)" in "(.*?)"$/) do |old_text, new_text, field|
  text = find_field(field).value
  text.should include(old_text)
  text = text.sub(old_text, new_text)
  fill_in field, with: text
end

Then(/^the word "(.*?)" should be highlighted$/) do |arg1|
  all("strong").map(&:text).join(" ").should include(arg1)
end

When(/^I fill "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end

Then(/^the current path should be "(.*?)"$/) do |arg1|
  URI.parse(current_url).path.should == arg1
end

Then(/^there should be a git repository in "(.*?)"$/) do |arg1|
  @repository = Rugged::Repository.new(arg1)
end

Then(/^the (branch|revision) "(.*?)" should have a file "(.*?)" containing "(.*?)"$/) do |kind, ref, filename, content|
  commit = @repository.rev_parse(ref)
  file = commit.tree.detect { |entry| entry[:name].force_encoding('utf-8') == filename }
  file.should_not be_nil, commit.tree.map { |entry| entry[:name].force_encoding('utf-8') }.inspect
  data = @repository.read(file[:oid]).data
  data.should include(content)
end
