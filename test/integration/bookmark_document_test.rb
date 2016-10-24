require "test_helper"

class BookmarkDocumentTest < ActionDispatch::IntegrationTest
  test "bookmarking document" do
    user = create(:user, has_document: true)
    document = user.documents.last

    visit root_path(as: user)
    click_link "Bookmark"
    within ".ion-bookmark + div" do
        assert page.has_content? document.title
    end
    click_link "Unbookmark"
    refute page.has_css? ".ion-bookmark + div"
  end

  test "removing bookmarked document" do
    user = create(:user, has_bookmark: true)
    visit root_path(as: user)
    click_link "Remove"
    assert user.documents.empty?
  end
end
