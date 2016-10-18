require 'test_helper'

class CreateDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "sanity" do
    visit root_path(as: @user)
    click_button "New document"
    within ".editor-sidebar-item" do
      assert page.has_content?("Untitled")
    end
    assert_equal editor_document_path(@user.documents.last), current_path
  end
end
