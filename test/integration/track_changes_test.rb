require "test_helper"

class TrackChangesTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user, has_document: true)
    @user_b = create(:user)
    @document = @user_a.documents.last
    create(:collaboration, share: @document, user: @user_b)
  end

  def disconnect(user)
    user.touch(:last_seen_at)
  end

  test "tracking changes" do
    skip
    disconnect @user_b
    visit root_path(as: @user_a)
    fill_in "document_body", with: "Edited"
    click_button "Save"
    visit root_path(as: @user_b)
    within '.editor-changeset' do
      assert page.has_content? "Edited by #{@user_a}"
    end
    disconnect @user_b
    visit root_path(as: @user_b)
    refute page.has_content? ".editor-changeset"
  end
end
