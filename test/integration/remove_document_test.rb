require 'test_helper'

class RemoveDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, has_document: true)
  end

  test "removing document" do
    visit root_path(as: @user)
    click_link "Remove"
    assert @user.documents.empty?
  end
end
