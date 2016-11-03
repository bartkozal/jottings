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
    # TODO extract to separate test file
    user = create(:user, has_document: true)
    document = user.documents.last
    stack = create(:stack, name: "Zzz", assign_to: user)
    empty_stack = create(:stack, name: "Aaa", assign_to: user)
    in_stack_document_a = create(:document, body: "# Zzz", assign_to: user, stack: stack)
    in_stack_document_b = create(:document, body: "# Aaa", assign_to: user, stack: stack)

    expected = {
      empty_stack => [],
      stack => [in_stack_document_b, in_stack_document_a],
      document => nil
    }

    assert_equal expected, user.tree_view
  end

  test "#find_document_through_collaborations" do
    skip
  end
end
