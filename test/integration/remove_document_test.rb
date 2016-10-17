require 'test_helper'

class RemoveDocumentTest < ActionDispatch::IntegrationTest
  test "sanity" do
    skip # TODO
    user = create(:user, has_document: true)
    visit root_path(as: user)
  end
end
