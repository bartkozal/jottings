require "test_helper"

class RemoveAccountTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user, has_bookmark: true, has_stack: true)
    @user_b = create(:user)
    @document = @user_a.documents.last
    @stack = @user_a.stacks.last
  end

  test "removing account" do
    visit root_path(as: @user_a)
    click_link "Settings"
    click_button "I know, remove my account"
    assert page.has_content?("Your account has been removed")
    assert User.find_by(id: @user_a.id).blank?
    assert_empty Collaboration.where(user: @user_a)
    assert_empty Bookmark.where(user: @user_a)
  end

  test "rejecting remove when shared stack exist" do
    @stack.collaborators << @user_b
    visit root_path(as: @user_a)
    click_link "Settings"
    click_button "I know, remove my account"
    assert page.has_content?("You can't remove the account until you pass the ownership of shared stacks.")
    assert User.find(@user_a.id).present?

    @stack.update(owner: @user_b)
    click_button "I know, remove my account"
    assert page.has_content?("Your account has been removed")
    assert User.find_by(id: @user_a.id).blank?
    assert_empty Stack.where(owner: @user_a)
  end
end
