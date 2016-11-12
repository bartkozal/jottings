require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#bookmarked?" do
    user = create(:user, has_bookmark: true)
    document = user.documents.last

    assert user.bookmarked?(document)
  end

  test "#own_shares?" do
    user_a = create(:user, has_document: true, has_stack: true)
    document = user_a.documents.last
    stack = user_a.stacks.last
    refute user_a.own_shares?

    user_b = create(:user)
    document.collaborators << user_b
    assert user_a.own_shares?

    user_a.documents.last.update(owner: user_b)
    refute user_a.own_shares?

    stack.collaborators << user_b
    assert user_a.own_shares?

    user_a.stacks.last.update(owner: user_b)
    refute user_a.own_shares?
  end

  test "#tree_view" do
    skip
  end

  test "#find_document" do
    skip
  end
end
