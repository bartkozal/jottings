require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  test "#title" do
    body = "First Line\r\nSecond Line\r\n\r\nThird Line"
    document = build(:document, body: body)

    assert_equal "First Line", document.title
  end

  test "#assign_to" do
    user = build(:user)
    document = build(:document)

    document.assign_to(user)

    assert_equal document.owner, user
    assert_includes document.collaborators, user
  end

  test "#owner?" do
    user = build(:user)
    document = build(:document)

    refute document.owner?(user)

    document.assign_to(user)

    assert document.owner?(user)
  end
end
