require 'test_helper'

class RenameStackTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, has_stack: true)
    @stack = @user.stacks.last
  end

  test "renaming stack" do
    visit root_path(as: @user)

    within ".editor-sidebar form[id^='edit_stack']" do
      assert page.has_css? "input[value='#{@stack}']"
      fill_in "stack[name]", with: "Example stack"
      click_button "Rename"
    end

    within ".editor-sidebar" do
      assert page.has_content?("Example stack")
    end
  end
end
