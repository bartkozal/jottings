require "test_helper"

class LeaveDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user)
    @user_b = create(:user, has_document: true)
    @document = @user_b.documents.last
    @document.collaborators << @user_a
  end

  test "leaving shared document" do
    visit root_path(as: @user_a)
    assert page.has_content?(@document)
    click_link "Leave"
    assert page.has_content? %(You left the document "#{@document}")
    within ".editor-sidebar" do
      refute page.has_content?(@document)
    end
  end

  test "leaving bookmarked document" do
    visit root_path(as: @user_a)
    click_link "Bookmark"
    click_link "Leave", match: :first
    refute page.has_css?(".sidebar-item-document")
  end
end
