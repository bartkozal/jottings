class Editor::Documents::MovesController < EditorController
  before_action :find_document
  before_action :find_stack, only: :create
  before_action :require_stack_ownership, only: :destroy
  before_action :require_stack_ownership, only: :create, if: -> { @document.stack.present? }
  before_action :require_no_collaborators, only: :create, if: -> { @document.stack.blank? }

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

  def require_stack_ownership
    raise ApplicationController::NotAuthorized unless @document.stack.owner?(current_user)
  end

  def require_no_collaborators
    raise ApplicationController::NotAuthorized if @document.has_collaborators?
  end
end
