require 'test_helper'

class RemoveAccountTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, has_document: true)
  end

  test "removing account" do
    visit root_path(as: @user)
    click_link "Settings"
    click_link "Remove account"
    assert page.has_content?("Your account has been removed")
    assert User.all.empty?
    assert Collaboration.all.empty?
  end

  test "rejecting remove when shared documents exist" do
    skip
  end
end
