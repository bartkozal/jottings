require 'test_helper'

class RemoveDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, has_document: true)
  end

  test "removing document" do
    visit root_path(as: @user)
    within '.editor-sidebar-item' do
      page.find("a[href='#{editor_document_path(@user.documents.last)}'][data-method='delete']").click
    end
    assert @user.documents.empty?
  end
end
