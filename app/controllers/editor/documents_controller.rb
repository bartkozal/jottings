class Editor::DocumentsController < EditorController
  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.new(document_params)
    if @document.save
      redirect_to edit_editor_document_path(@document)
    else
      render "new"
    end
  end

  def edit
    @document = find_document
  end

  def update
    @document = find_document
    if @document.update(document_params)
      redirect_to edit_editor_document_path(@document)
    else
      render "edit"
    end
  end

  def destroy
    @document = find_document
    @document.destroy
    redirect_to new_editor_document_path,
      notice: "Document \"#{@document.title}\" has been removed"
  end

  private

  def find_document
    current_user.documents.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:title, :body)
  end
end
