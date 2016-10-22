class Editor::DocumentsController < EditorController
  before_action :find_document, only: [:show, :update, :destroy]
  before_action :require_ownership , only: :destroy

  def show
  end

  def index
    if document = current_user.last_updated_document
      redirect_to editor_document_path(document)
    end
  end

  def create
    @document = Document.new(document_params)
    @document.assign_to(current_user)

    if @document.save
      redirect_to editor_document_path(@document)
    else
      render "new"
    end
  end

  def update
    if @document.update(document_params)
      redirect_to editor_document_path(@document)
    else
      render "edit"
    end
  end

  def destroy
    @document.destroy
    redirect_to editor_documents_path,
      notice: "Document \"#{@document.title}\" has been removed"
  end

  private

  def document_params
    params.require(:document).permit(:body)
  end
end
