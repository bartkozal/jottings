require "test_helper"

class DocumentChangesetTest < ActiveSupport::TestCase
  setup do
    @user_a = create(:user, has_document: true)
    @document = @user_a.documents.last
    @changeset = Document::Changeset.new
    @changeset.document = @document
  end

  test "#since_last_seen when user didn't leave document" do
    assert_nil @changeset.since_last_seen(@user_a)
  end

  test "#since_last_seen when user left document after an update" do
    travel_to 5.minutes.from_now do
      @user_a.touch(:last_seen_at)
    end
    assert_nil @changeset.since_last_seen(@user_a)
  end

  test "#since_last_seen when user is the author of an update" do
    travel_to 5.minutes.ago do
      @user_a.touch(:last_seen_at)
    end

    version_mock = Minitest::Mock.new
    version_mock.expect :whodunnit, "#{@user_a.id}"
    @changeset.stub :versions_since, [version_mock] do
      assert_nil @changeset.since_last_seen(@user_a)
    end
  end

  test "#since_last_seen when user isn't an author of an update" do
    travel_to 5.minutes.ago do
      @user_a.touch(:last_seen_at)
    end

    @user_b = create(:user)

    version_mock = Minitest::Mock.new
    diff_mock = Minitest::Mock.new
    diff_mock.expect :new, diff_mock, [version_mock]

    version_mock.expect :whodunnit, "#{@user_b.id}"
    @changeset.stub :versions_since, [version_mock] do
      Document::Changeset::Diff.stub :new, diff_mock do
        expected_collection = [Document::Changeset::Diff.new(version_mock)]
        assert_equal expected_collection, @changeset.since_last_seen(@user_a)
      end
    end
  end

  test "#versions_since" do
    assert_includes @changeset.versions_since(1.minute.ago), @document.versions.last

    travel_to 5.minutes.ago do
      assert_nil @changeset.versions_since(1.minute.ago)
    end
  end
end
