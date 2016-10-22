class EditorController < ApplicationController
  before_action :require_login
  layout "editor"

  protected

  def find_document
    param = params[:id] || params[:document_id]
    decoded_id = MaskedId.decode(param)
    @document = current_user.documents.includes(:collaborators).find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @document.owner?(current_user)
  end
end
