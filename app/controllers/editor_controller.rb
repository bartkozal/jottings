class EditorController < ApplicationController
  before_action :require_login
  layout "editor"

  protected

  def find_document(arg = params[:id])
    @document = current_user.documents.includes(:collaborators).find(arg)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @document.owner?(current_user)
  end
end
