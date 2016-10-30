require 'test_helper'

class CreateStackTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "creating stack" do
    visit root_path(as: @user)
    assert page.has_content?("New stack")
    fill_in "stack_name", with: "Example stack"
    click_button "Create"
    within ".editor-sidebar" do
      assert page.has_content?("Example stack")
    end
  end
end
