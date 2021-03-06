require 'uri'
require 'cgi'
require 'selenium-webdriver'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))
# enable javascript test
require 'webdrivers'


#====LOG-IN/ LOG-OUT

Given /^(?:|I )log in as (.+)$/ do |user|
  visit '/login'
  fill_in 'Login', :with => user_id(user)
  fill_in 'Password', :with => '123456'
  click_button 'Log in'
end


Given("I log out") do
  #select "Log out", :from => "Account"
  #click_link 'Account'
  #click_link 'Log out'
  find('#account_link').click
  #click_link 'Account'
  click_link 'Log out'
end

Given('I click "Account"') do
  find('#account_link').click
end

#====BASIC OPERATIONS

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )click link "([^"]*)"$/ do |link|
  click_link(link)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end


Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end
#"

When("I delete the first user") do
#"
   first(:link, "Delete").click

end

When /^I delete the user "([^"]*)"$/ do |name|
  user = User.find_by(:name => name)
  user.id

end

Given /^I expect to click "([^"]*)" on a confirmation box saying "([^"]*)"$/ do |option, message|
  retval = (option == "OK") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg)
    return #{retval}
  }")

end

When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end

When("I activate a user") do
  click_button 'Activate'
end

#" # ===== USER
Given /^I search user "([^"]*)"$/ do |user| #"
  fill_in "user_search", :with => user
  click_button "Search"
end

When /I (un)?check the following role: (.*)/ do |uncheck, category_list|
  category_list.split(', ').each do |category|
    step %{I #{uncheck.nil? ? '' : 'un'}check "roles[#{category}]"}
  end
end
#===== QUESTIONS

Given('I edit the first category into "pickle-rick"') do
  visit '/categories/1/edit'
  fill_in "Name", :with => "pickle-rick"
  click_button 'Save changes'
end

Given('I create a new category "pickle-morty"') do
  visit '/categories/new'
  fill_in "Name", :with => "pickle-morty"
  click_button 'Create my category'
end

Given('I edit subcategory "Business_1" into "pickle-rick_1"') do
  visit '/subcategories/1/edit'
  fill_in "Name", :with => "pickle-rick_1"
  fill_in "Weight", :with => "7.7"
  #select "pickle_morty", :from => "Subcategory"
  #find_field('subcategory_category_id option[pickle_morty]').text
  #find_field('subcategory_category_id').find('option[Security]').text
  click_button 'Save changes'
end

Given('I create a new subcategory "pickle-rick_4"') do
  #click_button 'New Subcategory'
  first(:button, 'New Subcategory').click
  fill_in "Name", :with => "pickle-rick_4"
  #fill_in "Weight", :with => "1.0"
  find('#subcategory_category_id').find(:xpath, 'option[4]').select_option
  click_button 'Create my subcategory'
end

Given('I edit question "Business_1_q1" into "pickle-rick_1_q1"') do
  visit '/questions/1/edit'
  fill_in "Name", :with => "pickle-rick_1_q1"
  click_button 'Save changes'
end

Given('I create a new question "pickle-rick_1_q4"') do
  first(:button, 'New Question').click
  fill_in "Name", :with => "pickle-rick_1_q4"
  fill_in "Weight", :with => "11.1"
  #select('pickle-rick_1', from: 'select_box')
  find('#question_subcategory_id').find(:xpath, 'option[10]').select_option
  click_button 'Create my question'
end

Given('I input invalid in "Weight"') do
  visit '/categories/new'
  fill_in "Name", :with => "invalid"
  fill_in "Weight", :with => "invalid"
  click_button 'Create my category'
end

Given('I delete the question "pickle-rick"') do
  first(:link, "Delete").click
end

Given('I comfirm the popup') do
  click_button('OK')
end

# ===== SCALES
When /I (un)?check the following category: (.*)/ do |uncheck, category_list|
  category_list.split(', ').each do |category|
    step %{I #{uncheck.nil? ? '' : 'un'}check "categories[#{category}]"}
  end
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

Given('I edit the first scale into "pickle-rick_scale"') do
  visit '/scales/1/edit'
  fill_in "Name", :with => "pickle-rick_scale"
  fill_in "Description", :with => "This is a description for scale"
  click_button 'Save changes'
end

Given('I create a new scale "pickle-morty_scale"') do
  click_button 'New Scale'
  fill_in "Name", :with => "pickle-morty_scale"
  fill_in "Description", :with => "This is another description for scale"
  find('#scale_category_id').find(:xpath, 'option[3]').select_option
  fill_in "Level", :with => "1"
  fill_in "Score", :with => "1.0"
  click_button 'Create new scale'
end

Given('I destroy a scale') do
  first(:link, "Destroy").click
end

Given('I accept the popup') do
  #click_link 'OK'
  #click_button('OK')
  page.driver.browser.switch_to.alert.accept
  #page.evaluate_script('window.confirm = function() { return true; }')
  #page.click('Remove')
end

# ===== SCENARIOS

Given('I create a new scenario "pickle-rick"') do
  click_button 'New Scenario'
  fill_in "Name", :with => "pickle-rick"
  fill_in "Description", :with => "This is a description for scenario"
  click_button 'Create my scenario'
end

Given('I create a new scenario "pickle-morty"') do
  click_button 'New Scenario'
  fill_in "Name", :with => "pickle-morty"
  fill_in "Description", :with => "This is a description for scenario (DM)"
  click_button 'Create my scenario'
end

Given('I edit scenario 1 into "pickle-morty"') do
  visit '/scenarios/1/edit'
  fill_in "Name", :with => "pickle-morty"
  fill_in "Description", :with => "This is another description for scenario"
  click_button 'Save changes'
end

Given /^I click "Assign" of scenario "([^"]*)"$/ do |scenario|
  id = Scenario.find_by(:name => scenario).id.to_s
  link = '/privileges?scenario_id=' + id
  visit link
end
#"
Given('I click "Assign" of "Example DM1" and "Exmaple DM2"') do
  first(:button, "Assign").click
  first(:button, "Assign").click
end
Given('I click "Delete" of "Example DM1"') do
  first(:button, "Delete").click
end

# ====== PROFILE
Given('I edit user name into "Sekiro"') do
  fill_in "Name", :with => "Sekiro"
  click_button 'Save changes'
end

Given  /^I change password into "([^"]*)"$/ do |pw|
  fill_in "Password", :with => pw

end

#"
Given /^I confirm password with "([^"]*)" and submit$/ do |pw|
  fill_in "Confirmation", :with => pw
  click_button 'Save changes'
end

#"
Given("I log in with new password") do
  visit '/login'
  fill_in 'Login', :with => '1006'
  fill_in 'Password', :with => '000000'
  click_button 'Log in'
end
# ====== COMPANIES
Given('I click "Validate" of "pickle-morty"') do
  #visit '/answers?company_id=1'
  first(:button, "Validate").click
end

Given('I click "Answer this question" of "Business_1_q1"') do
  #visit '/answers?company_id=1'
  first(:link, "Answer this question").click
end

Given('I answer and submit') do
  find('#answer_level').find(:xpath, 'option[4]').select_option
  click_button 'Submit my answer'
end

Given('I edit the answer and submit') do
  find('#answer_level').find(:xpath, 'option[5]').select_option
  click_button 'Edit my answer'
end

Given('I comment and attach file') do
  fill_in "Comment", :with => "This is an evidence for Business_1_q1."
  page.attach_file('File', File.join(Rails.root, '/features/upload_file/evidence.txt'))
  #attach_file('File', File.join(Rails.root, '/features/upload_file/evidence.txt'))
  #attach_file('File', "~/environment/TAMUART_new/features/upload_file/evidence.txt")
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end

Given('I click "Validate" of "Example CR1"') do
  visit '/answers?company_id=1'
end

# Given(/^I go back$/) do
#   page.evaluate_script('window.history.back()')
# end

Given('I validate this question and submit') do
  find('#answer_level').find(:xpath, 'option[6]').select_option
  fill_in "answer_validator_comment", :with => "This is a validation for Business_1_q1."
  click_button 'Validate'
end

Given('I mark "pickle-morty" as "Validated"') do
  first('#validated').find(:xpath, 'option[1]').select_option
  first(:button, "Finalize").click
end

Given /^(?:|I )invite user "([^"]*)" with email "([^"]*)"$/ do |user, email|
  fill_in "Name", :with => user
  fill_in "Email", :with => email
  click_button "Invite"
end








#====PROJECT

Then(/^I press submit$/) do
  click_button "Submit"
end


When /^I choose the file and press upload$/ do
  attach_file('file', 'features/test_1023.csv')
  click_button "Upload"
end

Then /^the file should be parsed$/ do
end

Then /^the content is stored in the database$/ do
  #assert_not_nil Question.where(keyword: "SERVICE PROVIDER IDENTIFICATION")
  #puts(Question.where(keyword: "SERVICE PROVIDER IDENTIFICATION").inspect)
  #assert (Question.where(keyword: "SERVICE PROVIDER IDENTIFICATION").exists?)
  #This isn't a web-facing element so it might be weird to test it?
end

Then /^I should see the page of questions listed$/ do
  assert_selector "a", text: "Question Keyword"
  assert_selector "td", text: "SERVICE PROVIDER IDENTIFICATION"
end

# disable button
Then(/^the "([^"]*)" button should be disabled$/) do |arg1|
  attributes = field_labeled(label).element.attributes.keys
  attributes.send(negate ? :should_not : :should, include('disabled'))
end


When /^I do not choose a file but press upload$/ do
  click_button "Upload"
end

Then /^the page should stay the same$/ do
  assert_selector "a", text: "Question Keyword"
  expect(page).to have_no_content("SERVICE PROVIDER IDENTIFICATION") #untested
end

When /^I upload the same file twice$/ do
  attach_file('file', 'features/test_1023.csv')
  click_button "Upload"
  attach_file('file', 'features/test_1023.csv')
  click_button "Upload"
end

Then /^the page should not list duplicates$/ do
  assert_selector "a", text: "Question Keyword"
  expect(page).to have_content("SERVICE PROVIDER IDENTIFICATION", count: 1)
end

#====END PROJECT

#====BEGIN AUTOGENERATED TRAINING WHEELS


module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^the blog is set up$/ do
  Blog.default.update_attributes!({:blog_name => 'Teh Blag',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  User.create!({:login => 'admin',
                :password => 'aaaaaaaa',
                :email => 'joe@snow.com',
                :profile_id => 1,
                :name => 'admin',
                :state => 'active'})
end
=begin
And /^I am logged into the admin panel$/ do
  visit '/home'

  fill_in 'user_email', :with => '1@1'
  fill_in 'user_password', :with => '123456'
  click_button 'Log in'
  #visit '/home'
  if page.respond_to? :should
    page.should have_content('Signed in successfully')
  else
    assert page.has_content?('Signed in successfully')
  end

end


=end

And /^I am signing up as an Admin$/ do
  visit '/home'
  fill_in 'user_email', :with => '1@1', :match => :first
  fill_in 'user_password', :with => '123456', :match => :first
  fill_in 'user_password_confirmation', :with => '123456'
  select 'Good Company', :from => 'Company'
  select 'Admin', :from => 'Role'
  click_button 'Sign up'
  #visit '/home'
  if page.respond_to? :should
    page.should have_content('Welcome! You have signed up successfully.')
  else
    assert page.has_content?('Welcome! You have signed up successfully.')
  end

end




# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step, parent|
  with_scope(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
  with_scope(parent) { When "#{step}:", table_or_string }
end

# Given /^(?:|I )am on (.+)$/ do |page_name|
#   visit path_to(page_name)
# end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

# When /^(?:|I )press "([^"]*)"$/ do |button|
#   click_button(button)
# end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end


When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end


# Then /^(?:|I )should see "([^"]*)"$/ do |text|
#   if page.respond_to? :should
#     page.should have_content(text)
#   else
#     assert page.has_content?(text)
#   end
# end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

# Then /^(?:|I )should not see "([^"]*)"$/ do |text|
#   if page.respond_to? :should
#     page.should have_no_content(text)
#   else
#     assert page.has_no_content?(text)
#   end
# end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')

  form_for_input = element.find(:xpath, 'ancestor::form[1]')
  using_formtastic = form_for_input[:class].include?('formtastic')
  error_class = using_formtastic ? 'error' : 'field_with_errors'

  if classes.respond_to? :should
    classes.should include(error_class)
  else
    assert classes.include?(error_class)
  end

  if page.respond_to?(:should)
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      error_paragraph.should have_content(error_message)
    else
      page.should have_content("#{field.titlecase} #{error_message}")
    end
  else
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      assert error_paragraph.has_content?(error_message)
    else
      assert page.has_content?("#{field.titlecase} #{error_message}")
    end
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')
  if classes.respond_to? :should
    classes.should_not include('field_with_errors')
    classes.should_not include('error')
  else
    assert !classes.include?('field_with_errors')
    assert !classes.include?('error')
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
