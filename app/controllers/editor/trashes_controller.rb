class Editor::TrashesController < EditorController
  def show
    @stacks = current_user.owned_stacks.only_deleted
    @documents = current_user.documents.only_deleted.without_deleted_in_stacks

    @removed_items_count = @stacks.count + @documents.count
  end
end
