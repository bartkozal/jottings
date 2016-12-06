class Editor::TrashesController < EditorController
  before_action :find_stacks, :find_documents

  def show
    @removed_items_count = @stacks.count + @documents.count
  end

  def destroy
    User.transaction do
      @stacks.each(&:really_destroy!)
      @documents.each(&:really_destroy!)
    end

    redirect_to editor_trash_path, alert: "Trash has been emptied"
  end

  private

  def find_stacks
    @stacks = current_user.owned_stacks.only_deleted
  end

  def find_documents
    @documents = current_user.documents.only_deleted.without_deleted_in_stacks
  end
end
