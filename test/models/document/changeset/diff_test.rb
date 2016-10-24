require "test_helper"

class DocumentChangesetDiffTest < ActiveSupport::TestCase
  def mock_version(whodunnit:, and_return:)
    collaborators_mock = Minitest::Mock.new
    collaborators_mock.expect :find_by, and_return, [id: whodunnit]

    item_mock = Minitest::Mock.new
    item_mock.expect :collaborators, collaborators_mock

    version_mock = Minitest::Mock.new
    version_mock.expect :whodunnit, whodunnit
    version_mock.expect :item, item_mock
    version_mock
  end

  setup do
    @user = create(:user)
  end

  test "#author when user exists" do
    version = mock_version(whodunnit: "#{@user.id}", and_return: @user)
    diff = Document::Changeset::Diff.new(version)
    assert_equal @user, diff.author
  end

  test "#author when user doesn't exist" do
    version = mock_version(whodunnit: "#{@user.id}", and_return: nil)
    diff = Document::Changeset::Diff.new(version)
    assert_equal "Unknown", diff.author
  end
end
