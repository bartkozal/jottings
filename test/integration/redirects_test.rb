require 'test_helper'

class RedirectsTest < ActionDispatch::IntegrationTest
  test "redirecting to last visited document" do
    user = create(:user, has_document: true)
    document = build(:document, body: Faker::Lorem.paragraph)
    document.assign_to(user)
    document.save

    document_a = user.documents.first
    document_b = user.documents.last

    visit root_path(as: user)
    click_link document_b
    click_link document_a
    click_link "Sign out"
    visit root_path(as: user)
    assert_equal editor_document_path(document_a), current_path
  end
end
