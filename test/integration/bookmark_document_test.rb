require "test_helper"

class BookmarkDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, has_document: true)
    @document = @user.documents.last
  end

  test "bookmarking document" do
    visit root_path(as: @user)
    click_link "Bookmark"
    within ".ion-bookmark + div" do
        assert page.has_content? @document.title
    end
    click_link "Unbookmark"
    refute page.has_css? ".ion-bookmark + div"
  end
end
