require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#bookmarked?" do
    user = create(:user, has_bookmark: true)
    document = user.documents.last

    assert user.bookmarked?(document)
  end

  test "#own_shared_stacks?" do
    user_a = create(:user, has_stack: true)
    user_b = create(:user)
    stack = user_a.stacks.first

    refute user_a.own_shared_stacks?

    stack.collaborators << user_b
    assert user_a.own_shared_stacks?

    user_a.stacks.first.update(owner: user_b)
    refute user_a.own_shared_stacks?
  end
end
