require "test_helper"

class CreateDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "creating document" do
    visit root_path(as: @user)
    assert page.has_content?("New document")
    within "#new_document" do
      fill_in "document_name", with: "Test document"
      click_button "Create"
    end
    within ".editor-sidebar" do
      assert page.has_content?("Test document")
    end
    assert_equal editor_document_path(@user.documents.last), current_path
  end
end
