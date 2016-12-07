require "test_helper"

class CreateStackTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "creating stack" do
    visit root_path(as: @user)
    assert page.has_content?("New stack")
    within "#new_stack" do
      fill_in "stack_name", with: "Example stack"
      click_button "Create"
    end
    within ".editor-sidebar" do
      assert page.has_content?("Example stack")
    end
  end

  test "creating stack with collaborators" do
    visit root_path(as: @user)
    within "#new_stack" do
      fill_in "stack_name", with: "Example stack"
      fill_in "stack_collaborations_attributes_0_email", with: "test@example.com"
      assert page.has_css?("#stack_collaborations_attributes_1_email")
      assert page.has_link?("Invite more people")
      click_button "Create"
    end
    within ".editor-sidebar" do
      assert page.has_content?("Example stack")
    end
    click_link "Collaborators"
    assert page.has_content?("test@example.com")
  end
end
