require "test_helper"

class SendDocumentCollaborationEmailTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = create(:user, has_document: true)
    @document = @user_a.documents.last
  end

  test "sending inivitation email to non-existing user" do
    new_user_email = Faker::Internet.email
    visit root_path(as: @user_a)
    click_link "Share"
    fill_in "collaboration_email", with: new_user_email
    perform_enqueued_jobs do
      click_button "Invite"
    end
    assert page.has_content? %(#{new_user_email} invited to collaborate on "#{@document}")
    assert page.has_content?("Pending")
    click_link "Sign out"
    open_email new_user_email
    assert_equal %(You are invited to collaborate on "#{@document}"), current_email.subject
    current_email.click_link %(Click to see and start working on "#{@document}")
    fill_in "Password", with: Faker::Internet.password
    click_button "Sign up"
    assert_equal editor_document_path(@document), current_path
  end

  test "sending notification email to existing user" do
    @user_b = create(:user)
    visit root_path(as: @user_a)
    click_link "Share"
    fill_in "collaboration_email", with: @user_b.email
    perform_enqueued_jobs do
      click_button "Invite"
    end
    open_email @user_b.email
    assert_equal %(You are invited to collaborate on "#{@document}"), current_email.subject
    current_email.click_link %(Click to see and start working on "#{@document}")
    assert_equal editor_document_path(@document), current_path
  end
end
