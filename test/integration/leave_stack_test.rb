require "test_helper"

class LeaveStackTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user)
    @user_b = create(:user, has_stack: true)
    @stack = @user_b.stacks.last
    @stack.collaborators << @user_a
  end

  test "leaving shared stack" do
    visit root_path(as: @user_a)
    assert page.has_content?(@stack)
    click_link "Leave"
    assert page.has_content?("You left the stack \"#{@stack}\"")
    within ".editor-sidebar" do
      refute page.has_content?(@stack)
    end
  end

  test "leaving document from the shared stack" do
    document = @stack.documents.create(owner: @user_a)
    visit root_path(as: @user_a)
    within ".sidebar-item-document" do
      refute page.has_link?("Leave")
    end

    within ".sidebar-item-stack" do
      click_link "Leave"
    end
    refute page.has_content?(document)

    visit root_path(as: @user_b)
    assert page.has_content?(document)
  end
end
