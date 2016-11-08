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
      if @collaboration.invite?
        CollaborationMailer.invite(@collaboration).deliver_later
        redirect_to editor_document_share_path(@document),
          notice: %(#{@collaboration.invite_email} invited to collaborate on "#{@document}")
      else
        CollaborationMailer.notify(@collaboration).deliver_later
        redirect_to editor_document_share_path(@document),
          flash: { success: "#{@collaboration.user} has been added to the document" }
      end
    else
      render :show
    end
  end

  def destroy
    @user = @document.collaborators.find_by(email: params[:email])
    @document.collaborators.destroy(@user)
    redirect_to editor_document_share_path(@document),
      alert: "#{@user} has been removed from the document"
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:email)
  end

  def find_document
    decoded_id = MaskedId.decode(:document, params[:document_id])
    @document = current_user.documents.includes(:collaborators).find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @document.owner?(current_user)
  end
end
