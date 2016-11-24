require "test_helper"

class RenameDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, has_document: true)
    @document = @user.documents.last
  end

  test "renaming document" do
    visit root_path(as: @user)

    within ".editor-sidebar form[id^='edit_document']" do
      assert page.has_css? "input[value='#{@document}']"
      fill_in "document[name]", with: "New name"
      click_button "Rename"
    end

    within ".editor-sidebar" do
      assert page.has_content?("New name")
    end
  end
end
