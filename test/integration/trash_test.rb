require "test_helper"

class TrashTest < ActionDispatch::IntegrationTest
  test "removing document moves it to the trash" do
    user = create(:user)
    document = create(:document, user: user)

    visit root_path(as: user)
    click_link "Remove"
    click_link "Trash"
    within ".editor-content" do
      assert page.has_content?(document.name)
    end
  end

  test "removing stack with documents only shows stack in the trash" do
    user = create(:user)
    stack = create(:stack, assign_to: user)
    document = create(:document, user: user, stack: stack)

    visit root_path(as: user)
    click_link "Remove", match: :first
    click_link "Trash"
    within ".editor-content" do
      refute page.has_content?(document.name)
      assert page.has_content?(stack.name)
    end
  end

  test "seeing stack in trash only by the owner" do
    user_a = create(:user, has_stack: true)
    user_b = create(:user)
    stack = user_a.stacks.last
    stack.collaborators << user_b

    visit root_path(as: user_a)
    click_link "Remove"
    click_link "Trash"
    within ".editor-content" do
      assert page.has_content?(stack.name)
    end

    visit root_path(as: user_b)
    click_link "Trash"
    within ".editor-content" do
      refute page.has_content?(stack.name)
    end
  end

  test "restoring removed document" do
    user = create(:user, has_document: true)
    document = user.documents.last

    visit root_path(as: user)
    click_link "Remove"
    click_link "Trash"
    click_link "Restore"

    within ".editor-sidebar" do
      assert page.has_content?(document.name)
    end
  end

  test "removing document permanently" do
    user = create(:user, has_document: true)
    document = user.documents.last

    visit root_path(as: user)
    click_link "Remove"
    click_link "Trash"
    click_link "Delete Forever"

    within ".editor-content" do
      refute page.has_content?(document.name)
    end
  end

  test "restoring removed stack" do
    user = create(:user, has_stack: true)
    stack = user.stacks.last

    visit root_path(as: user)
    click_link "Remove"
    click_link "Trash"
    click_link "Restore"

    within ".editor-sidebar" do
      assert page.has_content?(stack.name)
    end
  end

  test "removing stack permanently" do
    user = create(:user, has_stack: true)
    stack = user.stacks.last

    visit root_path(as: user)
    click_link "Remove"
    click_link "Trash"
    click_link "Delete Forever"

    within ".editor-content" do
      refute page.has_content?(stack.name)
    end
  end

  test "empting trash" do
    user = create(:user, has_document: true, has_stack: true)
    stack = user.stacks.last
    document = user.documents.last

    visit root_path(as: user)
    click_link "Remove", match: :first
    click_link "Remove"
    click_link "Trash"
    click_link "Empty"

    refute page.has_content?(stack.name)
    refute page.has_content?(document.name)
  end
end
