class Editor::Documents::LeavesController < EditorController
  before_action :find_document

  def create
    @document.collaborators.destroy(current_user)
    redirect_to root_path, notice: "You left the document \"#{@document}\""
  end

  private

  def find_document
    decoded_id = MaskedId.decode(:document, params[:document_id])
    @document = current_user.documents.includes(:collaborators).find(decoded_id)
  end
end
