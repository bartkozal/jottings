require "test_helper"

class BookmarkDocumentTest < ActionDispatch::IntegrationTest
  test "bookmarking document" do
    user = create(:user, has_document: true)

    visit root_path(as: user)
    click_link "Bookmark"
    within ".editor-sidebar" do
        assert page.has_css? ".sidebar-item-document", count: 2
    end
    click_link "Unbookmark", match: :first
    refute page.has_css? ".sidebar-item-document", count: 2
  end

  test "removing bookmarked document" do
    user = create(:user, has_bookmark: true)
    visit root_path(as: user)
    click_link "Remove", match: :first
    assert user.documents.empty?
  end
end
