class Editor::Documents::OwnershipsController < EditorController
  before_action :find_document
  before_action :require_ownership

  def update
    @user = @document.collaborators.find_by(email: user_email)
    @document.owner = @user
    @document.save
    redirect_to editor_document_path(@document),
      notice: "#{@user} is a new owner of \"#{@document}\""
  end

  private

  def find_document
    decoded_id = MaskedId.decode(:document, params[:document_id])
    @document = current_user.documents.find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @document.owner?(current_user)
  end

  def user_email
    params.require(:user_email)
  end
end
