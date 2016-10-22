class Editor::CollaborationsController < EditorController
  before_action -> { find_document(params[:document_id]) }
  before_action :require_ownership
  before_action :find_user, only: :destroy

  def show
    @collaboration = Collaboration.new
  end

  def create
    @collaboration = Collaboration.new(collaboration_params)
    @collaboration.document = @document

    if @collaboration.save
      redirect_to editor_document_share_path(@document),
        flash: { success: "#{@collaboration.user} has been added to the document" }
    else
      render :show
    end
  end

  def destroy
    @document.collaborators.delete(@user)
    redirect_to editor_document_share_path(@document),
      notice: "#{@user} has been removed from the document"
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:user_email)
  end

  def find_user
    @user = User.find_by(email: params[:user_email])
  end
end
