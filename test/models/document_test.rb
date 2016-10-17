require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  test "#title" do
    body = "First Line\r\nSecond Line\r\n\r\nThird Line"
    document = Document.new(body: body)

    assert_equal "First Line", document.title
  end

  test "#assign_to" do
    user = User.new
    document = Document.new

    document.assign_to(user)

    assert_equal document.owner, user
    assert_includes document.collaborators, user
  end
end
