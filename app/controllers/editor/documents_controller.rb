class Editor::DocumentsController < EditorController
  before_action :find_document, only: [:show, :update, :destroy]
  before_action :require_ownership , only: :destroy

  def show
    @changeset = @document.changeset_since_last_seen(current_user)
    cookies.permanent.signed[:last_visited_document] = @document.to_param
  end

  def index
    if param = cookies.signed[:last_visited_document]
      decoded_id = MaskedId.decode(:document, param)
      if document = current_user.documents.find_by(id: decoded_id)
        redirect_to editor_document_path(document) and return
      end
    end

    if document = current_user.last_updated_document
      redirect_to editor_document_path(document) and return
    end
  end

  def create
    @document = Document.new
    @document.assign_to(current_user)

    if @document.save
      redirect_to editor_document_path(@document)
    else
      redirect_to editor_documents_path
    end
  end

  def update
    if @document.update(document_params)
      redirect_to editor_document_path(@document)
    else
      redirect_to editor_documents_path
    end
  end

  def destroy
    @document.transaction do
      current_user.find_bookmark(@document)&.destroy
      @document.destroy
    end

    redirect_to editor_documents_path,
      alert: "Document \"#{@document}\" has been removed"
  end

  private

  def find_document
    decoded_id = MaskedId.decode(:document, params[:id])
    @document = current_user.documents.includes(:collaborators).find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @document.owner?(current_user)
  end

  def document_params
    params.require(:document).permit(:body)
  end
end
