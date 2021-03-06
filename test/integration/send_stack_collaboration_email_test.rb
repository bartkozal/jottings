require "test_helper"

class SendStackCollaborationEmailTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user, has_stack: true)
    @stack = @user_a.stacks.first
    @new_user_email = Faker::Internet.email
  end

  test "sending inivitation email when user doesn't have account" do
    visit root_path(as: @user_a)
    click_link "Sharing"
    fill_in "collaboration_email", with: @new_user_email
    perform_enqueued_jobs do
      click_button "Invite"
    end
    assert page.has_content? %(#{@new_user_email} has been invited to collaborate on "#{@stack}")
    assert page.has_content?("Pending")
    click_link "Sign out"
    open_email @new_user_email
    assert_equal %(#{@stack.owner} invited you to work on Markdown documents with Jottings), current_email.subject
    current_email.click_link %(Join and start writing)
    fill_in "Password", with: Faker::Internet.password
    click_button "Sign up"
    assert_equal editor_document_path(@stack.documents.last), current_path
  end

  test "don't send invitation email when user exists" do
    @user_b = create(:user)
    visit root_path(as: @user_a)
    click_link "Sharing"
    fill_in "collaboration_email", with: @user_b.email
    perform_enqueued_jobs do
      click_button "Invite"
    end
    open_email @user_b.email
    assert_nil current_email
    assert_equal editor_stack_share_path(@user_a.stacks.first), current_path
  end

  test "canceling invite" do
    visit root_path(as: @user_a)
    click_link "Sharing"
    fill_in "collaboration_email", with: @new_user_email
    click_button "Invite"
    click_link "Cancel"
    within ".editor-content" do
      refute page.has_content?(@new_user_email)
    end
    assert page.has_content?("Invite to #{@new_user_email} has been canceled")
  end
end
