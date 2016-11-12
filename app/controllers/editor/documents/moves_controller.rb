class Editor::Documents::MovesController < EditorController
  before_action :find_document
  before_action :find_stack, only: :create
  # before_action :require_ownership

  # TODO
  # Don't allow to move documents out of shared stack if not an owner
  # Don't allow to move shared documents into shared stacks

  def create
    @document.stack = @stack
    @document.save
    head :ok
  end

  def destroy
    @document.stack = nil
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
