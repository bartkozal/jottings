require "test_helper"

class UserTreeViewTest < ActiveSupport::TestCase
  setup do
    user = create(:user, has_document: true)

    @stack = create(:stack, assign_to: user)
    @document = user.documents.last
    @empty_stack = create(:stack, assign_to: user)
    @in_stack_document_a = create(:document, assign_to: user, stack: @stack)
    @in_stack_document_b = create(:document, assign_to: user, stack: @stack)

    @tree_view = User::TreeView.new(documents: user.documents, stacks: user.stacks)
  end

  test "#stacks" do
    skip
    expected = {
      @empty_stack => [],
      @stack => [@in_stack_document_a, @in_stack_document_b]
    }

    assert_equal expected, @tree_view.stacks
  end

  test "#documents" do
    assert_equal [@document], @tree_view.documents
  end

  test "#arrange" do
    skip
    expected = {
      @empty_stack => [],
      @stack => [@in_stack_document_a, @in_stack_document_b],
      @document => nil
    }

    assert_equal expected, @tree_view.arrange
  end
end
