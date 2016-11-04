class LeaveDocumentTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user)
    @user_b = create(:user, has_document: true)
    @document = @user_b.documents.last
  end

  test "leaving shared document" do
    @document.collaborators << @user_a
    visit root_path(as: @user_a)
    assert page.has_content?(@document)
    click_link "Leave"
    assert page.has_content?("You left the document \"#{@document}\"")
    within ".editor-sidebar" do
      refute page.has_content?(@document)
    end
  end

  test "leaving document from the shared stack" do
    skip
  end

  test "leaving bookmarked document" do
    skip
  end
end
