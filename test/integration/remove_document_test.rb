require "test_helper"

class RemoveDocumentTest < ActionDispatch::IntegrationTest
  test "removing document" do
    user = create(:user, has_document: true)
    visit root_path(as: user)
    click_link "Remove"
    assert user.documents.empty?
  end

  test "removing document with bookmarks" do
    user = create(:user, has_bookmark: true)
    visit root_path(as: user)
    click_link "Remove", match: :first
    assert user.bookmarks.empty?
    assert user.documents.empty?
  end
end
