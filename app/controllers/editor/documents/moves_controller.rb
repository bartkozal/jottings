class Editor::Documents::MovesController < EditorController
  before_action :find_document
  before_action :find_stack, only: :create

  def create
    @document.stack = @stack
    @document.save
    head :ok
  end

  def destroy
    @document.stack = current_user.root_stack
    @document.save
    head :accepted
  end

  private

  def find_document
    decoded_id = MaskedId.decode(:document, params[:document_id])
    @document = current_user.documents.find(decoded_id)
  end

  def find_stack
    decoded_id = MaskedId.decode(:stack, params[:id])
    @stack = current_user.stacks.find(decoded_id)
  end
end
