require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  test "#title" do
    document = build(:document)

    document.body = "First Line\n\nSecond Line\n\n\n\nThird Line"
    assert_equal "First Line", document.title

    document.body = "# First Line"
    assert_equal "First Line", document.title

    document.body = "### First Line"
    assert_equal "First Line", document.title

    document.body = "-   First Line"
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
