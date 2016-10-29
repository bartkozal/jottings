class Editor::Documents::CollaborationsController < EditorController
  before_action :find_document
  before_action :require_ownership

  def show
    @collaboration = Collaboration.new
  end

  def create
    @collaboration = Collaboration.new(collaboration_params)
    @collaboration.share = @document

    if @collaboration.save
      redirect_to editor_document_share_path(@document),
        flash: { success: "#{@collaboration.user} has been added to the document" }
    else
      render :show
    end
  end

  def destroy
    @user = @document.collaborators.find_by(email: params[:user_email])
    @document.collaborators.delete(@user)
    redirect_to editor_document_share_path(@document),
      alert: "#{@user} has been removed from the document"
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:user_email)
  end

  def find_document
    decoded_id = MaskedId.decode(:document, params[:document_id])
    @document = current_user.documents.includes(:collaborators).find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @document.owner?(current_user)
  end
end
