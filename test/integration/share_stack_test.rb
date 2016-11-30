require "test_helper"

class ShareStackTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user)
    @user_b = create(:user, has_stack: true)
    @stack = @user_b.stacks.last
  end

  test "sharing stacks" do
    visit root_path(as: @user_a)
    refute page.has_content?(@stack)

    visit root_path(as: @user_b)
    click_link "Collaborators"
    fill_in "collaboration_email", with: @user_a.email
    click_button "Invite"
    assert page.has_content?(@user_a)

    visit root_path(as: @user_a)
  end

  test "passing ownership" do
    visit root_path(as: @user_b)
    click_link "Collaborators"
    fill_in "collaboration_email", with: @user_a.email
    click_button "Invite"
    click_link "Make owner"
    refute page.has_link?("Share")
    assert_equal @user_a, @user_b.stacks.last.owner
  end

  test "accessing document from the shared stacks" do
    document = create(:document, stack: @stack)
    @stack.collaborators << @user_a
    visit root_path(as: @user_a)
    within ".editor-sidebar" do
      click_link(document.name)
    end
    assert_equal editor_document_path(document), current_path
  end
end
