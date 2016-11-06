require "test_helper"

class RedirectsTest < ActionDispatch::IntegrationTest
  test "redirecting to last visited document" do
    user = create(:user, has_document: true)
    create(:document, body: Faker::Lorem.paragraph, assign_to: user)

    document_a = user.documents.first
    document_b = user.documents.last

    visit root_path(as: user)
    click_link document_b
    click_link document_a
    click_link "Sign out"
    visit root_path(as: user)
    assert_equal editor_document_path(document_a), current_path
  end

  test "redirecting on try to visit unauthorized documents" do
    user_a = create(:user)
    user_b = create(:user, has_document: true)
    document = user_b.documents.last

    visit root_path(as: user_a)
    visit editor_document_path(document)
    assert_equal root_path, current_path

    visit root_path(as: user_b)
    visit editor_document_path(document)
    assert_equal editor_document_path(document), current_path
  end

  test "signing out" do
    user = create(:user)
    visit root_path(as: user)
    click_link "Sign out"
    assert_equal sign_in_path, current_path
  end
end
