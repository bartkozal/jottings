class Editor::Documents::RestoresController < EditorController
  before_action :find_document

  def create
    @document.restore
    redirect_to editor_trash_path, notice: %("#{@document}" has been restored)
  end

  def destroy
    @document.really_destroy!
    redirect_to editor_trash_path, alert: %("#{@document}" has been permanently removed)
  end

  private

  def find_document
    decoded_id = MaskedId.decode(:document, params[:document_id])
    @document = current_user.documents.only_deleted.find(decoded_id)
  end
end
