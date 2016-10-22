require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#bookmarked?" do
    user = create(:user, has_bookmark: true)
    document = user.documents.last

    assert user.bookmarked?(document)
  end

  test "#own_shared_documents?" do
    user_a = create(:user, has_document: true)
    document = user_a.documents.last
    refute user_a.own_shared_documents?

    user_b = create(:user)
    document.collaborators << user_b
    assert user_a.own_shared_documents?

    user_a.documents.last.update(owner: user_b)
    refute user_a.own_shared_documents?
  end
end
