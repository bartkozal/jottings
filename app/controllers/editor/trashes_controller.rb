class Editor::TrashesController < EditorController
  def show
    @documents = current_user.documents.only_deleted.without_deleted_in_stacks
    @stacks = current_user.owned_stacks.only_deleted
  end
end
