require 'test_helper'

class UserSettingsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)

    @new_name = Faker::Name.name
    @new_email = Faker::Internet.email
    @new_password  = Faker::Internet.password
  end

  test "updating name and email" do
    visit root_path(as: @user)
    click_link "Settings"
    fill_in "Name", with: @new_name
    fill_in "E-mail", with: @new_email
    fill_in "Password", with: ""
    click_button "Update"
    assert_equal @new_name, User.last.name
    assert_equal @new_email, User.last.email
    click_link "Sign out"
    visit sign_in_path
    fill_in "E-mail", with: @new_email
    fill_in "Password", with: @user.password
    click_button "Sign in"
    assert page.has_button?("New document")
  end

  test "updating password" do
    visit root_path(as: @user)
    click_link "Settings"
    fill_in "user_password", with: @new_password
    click_button "Update"
    click_link "Sign out"
    visit sign_in_path
    fill_in "E-mail", with: @user.email
    fill_in "Password", with: @new_password
    click_button "Sign in"
    assert page.has_button?("New document")
  end
end
