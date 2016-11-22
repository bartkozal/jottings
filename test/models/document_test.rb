require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  setup do
    @document = build(:document)
    @user = build(:user)
  end

  test "#to_s" do
    @document.title = "Title"
    assert_equal "Title", @document.to_s

    @document.title = ""
    assert_equal "Untitled document", @document.to_s

    @document.title = nil
    assert_equal "Untitled document", @document.to_s
  end

  test "#assign_to" do
    @document.assign_to(@user)
    assert_equal @document.owner, @user
    assert_includes @document.collaborators, @user
  end

  test "#owner?" do
    refute @document.owner?(@user)
    @document.assign_to(@user)
    assert @document.owner?(@user)
  end

  test "#changeset_since_last_seen" do
    changeset_mock = Minitest::Mock.new
    changeset_mock.expect :document=, nil, [@document]
    changeset_mock.expect :since_last_seen, nil, [@user]

    Document::Changeset.stub :new, changeset_mock do
      @document.changeset_since_last_seen(@user)
    end
  end
end
