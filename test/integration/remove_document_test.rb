require 'test_helper'

class RemoveDocumentTest < ActionDispatch::IntegrationTest
  setup do
    skip
    @user = create(:user, has_document: true)
  end

  test "sanity" do
    visit root_path(as: @user)
    page.find(".editor-sidebar-item").hover
    assert page.find(".ion-trash-a").visible?
    page.find("a[href='#{editor_document_path(@user.documents.last)}'][data-method='delete']").click
    assert @user.documents.empty?
  end
end
