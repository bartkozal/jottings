require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#bookmarked?" do
    user = create(:user, has_document: true)
    document = user.documents.last

    create(:bookmark, user: user, document: document)

    assert user.bookmarked?(document)
  end
end
