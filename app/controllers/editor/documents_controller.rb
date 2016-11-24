class Editor::DocumentsController < EditorController
  before_action :find_document, only: [:show, :update, :destroy]
  before_action :require_collaboration , only: :destroy

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
    @document = Document.new(document_params)
    @document.assign_to(current_user)

    if @document.save
      redirect_to editor_document_path(@document)
    else
      redirect_to editor_documents_path
    end
  end

  def update
    @document.update(document_params)
    redirect_to editor_documents_path
  end

  def destroy
    @document.transaction do
      @document.bookmarks.destroy_all
      @document.destroy
    end

    redirect_to editor_documents_path,
      alert: %(Document "#{@document}" has been removed)
  end

  private

  def find_document
    decoded_id = MaskedId.decode(:document, params[:id])
    return if @document = current_user.find_document(decoded_id)
    raise ApplicationController::NotAuthorized
  end

  def require_collaboration
    raise ApplicationController::NotAuthorized unless @document.has_collaborator?(current_user)
  end

  def document_params
    params.require(:document).permit(:name)
  end
end
