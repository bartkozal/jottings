class Editor::OwnershipsController < EditorController
  before_action :find_document
  before_action :require_ownership

  def update
    @user = User.find_by(email: user_email)
    @document.owner = @user
    @document.save
    redirect_to editor_document_path(@document),
      notice: "#{@user} is a new owner of \"#{@document}\""
  end

  private

  def user_email
    params.require(:user_email)
  end
end
