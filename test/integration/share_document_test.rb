require 'test_helper'

class ShareDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user)
    @user_b = create(:user, has_document: true)
    @document = @user_b.documents.last
  end

  test "sharing documents" do
    visit root_path(as: @user_a)
    refute page.has_content?(@document.title)

    visit root_path(as: @user_b)
    click_link "", href: editor_document_path(@document), match: :first
    click_link "Share"
    fill_in "collaboration_user_email", with: @user_a.email
    click_button "Invite"
    assert page.has_content?(@user_a.email)

    visit root_path(as: @user_a)
    click_link "", href: editor_document_path(@document), match: :first
    within ".editor-content" do
      assert page.has_css?("img[alt=\"Avatar of #{@user_a.email}\"]")
      assert page.has_css?("img[alt=\"Avatar of #{@user_b.email}\"]")
    end
  end

  test "passing ownership" do
    visit root_path(as: @user_b)
    click_link "Share"
    fill_in "collaboration_user_email", with: @user_a.email
    click_button "Invite"
    click_link "Make owner"
    assert_equal editor_document_path(@document), current_path
    refute page.has_link?("Share")
    assert_equal @user_a, @user_b.documents.last.owner
  end
end
