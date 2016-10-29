class Editor::Stacks::CollaborationsController < EditorController
  before_action :find_stack
  before_action :require_ownership

  def show
    @collaboration = Collaboration.new
  end

  def create
    @collaboration = Collaboration.new(collaboration_params)
    @collaboration.share = @stack

    if @collaboration.save
      redirect_to editor_stack_share_path(@stack),
        flash: { success: "#{@collaboration.user} has been added to the stack" }
    else
      render :show
    end
  end

  def destroy
    @user = @stack.collaborators.find_by(email: params[:user_email])
    @stack.collaborators.delete(@user)
    redirect_to editor_stack_share_path(@stack),
      alert: "#{@user} has been removed from the stack"
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:user_email)
  end

  def find_stack
    decoded_id = MaskedId.decode(:stack, params[:stack_id])
    @stack = current_user.stacks.includes(:collaborators).find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @stack.owner?(current_user)
  end
end
