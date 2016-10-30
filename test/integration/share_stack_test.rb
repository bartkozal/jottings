require 'test_helper'

class ShareStackTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user)
    @user_b = create(:user, has_stack: true)
    @stack = @user_b.stacks.last
  end

  test "sharing stacks" do
    visit root_path(as: @user_a)
    refute page.has_content?(@stack.name)

    visit root_path(as: @user_b)
    click_link "Share"
    fill_in "collaboration_user_email", with: @user_a.email
    click_button "Invite"
    assert page.has_content?(@user_a.email)

    visit root_path(as: @user_a)
  end

  test "passing ownership" do
    visit root_path(as: @user_b)
    click_link "Share"
    fill_in "collaboration_user_email", with: @user_a.email
    click_button "Invite"
    click_link "Make owner"
    refute page.has_link?("Share")
    assert_equal @user_a, @user_b.stacks.last.owner
  end
end
