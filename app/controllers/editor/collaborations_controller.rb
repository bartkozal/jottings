class Editor::CollaborationsController < EditorController
  before_action -> { find_document(params[:document_id]) }
  before_action :require_ownership
  before_action :find_user, only: [:create, :destroy]

  def show
  end

  def create
    collaboration = Collaboration.new(document: @document, user: @user)

    if collaboration.save
      redirect_to editor_document_share_path(@document),
        flash: { success: "#{params[:email]} has been added to the document" }
    else
      redirect_to editor_document_share_path(@document),
        alert: "#{params[:email]} doesn't have an account"
    end
  end

  def destroy
    @document.collaborators.delete(@user)
    redirect_to editor_document_share_path(@document),
      notice: "#{params[:email]} has been removed from the document"
  end

  private

  def find_user
    @user = User.find_by(email: params[:email])
  end
end
