class Editor::Documents::MovesController < EditorController
  before_action :find_document
  before_action :find_stack, only: :create
  before_action :require_move_ability
  before_action :require_no_collaborators, only: :create

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

  def require_move_ability
    raise ApplicationController::NotAuthorized unless @document.can_move?(current_user)
  end

  def require_no_collaborators
    raise ApplicationController::NotAuthorized if @document.has_shared_stack?
  end
end
