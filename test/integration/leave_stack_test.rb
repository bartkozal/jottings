require "test_helper"

class LeaveStackTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user)
    @user_b = create(:user, has_stack: true)
    @stack = @user_b.stacks.first
    @stack.collaborators << @user_a
  end

  test "leaving shared stack" do
    visit root_path(as: @user_a)
    assert page.has_content?(@stack)
    click_link "Leave"
    assert page.has_content? %(You left the stack "#{@stack}")
    within ".editor-sidebar" do
      refute page.has_content?(@stack)
    end
  end
end
