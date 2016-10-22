require 'test_helper'

class RemoveAccountTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user, has_bookmark: true)
    @user_b = create(:user)
    @document = @user_a.documents.last
  end

  test "removing account" do
    visit root_path(as: @user_a)
    click_link "Settings"
    click_link "Remove account"
    assert page.has_content?("Your account has been removed")
    assert User.find_by(id: @user_a.id).blank?
    assert Collaboration.all.empty?
    assert Bookmark.all.empty?
  end

  test "rejecting remove when shared documents exist" do
    @document.collaborators << @user_b
    visit root_path(as: @user_a)
    click_link "Settings"
    click_link "Remove account"
    assert page.has_content?("You can't remove the account until you pass the ownership of shared documents.")
    refute User.find(@user_a.id).blank?

    @document.update(owner: @user_b)
    click_link "Remove account"
    assert page.has_content?("Your account has been removed")
    assert User.find_by(id: @user_a.id).blank?
    refute Collaboration.all.empty?
  end
end
