class Editor::Stacks::CollaborationsController < EditorController
  before_action :find_stack
  before_action :require_ownership

  def show
    @collaboration = Collaboration.new
  end

  def create
    @collaboration = Collaboration.new(collaboration_params)
    @collaboration.stack = @stack

    if @collaboration.save
      if @collaboration.invite?
        CollaborationMailer.invite(@collaboration).deliver_later
        redirect_to editor_stack_share_path(@stack),
          notice: %(#{@collaboration.invite_email} invited to collaborate on "#{@stack}")
      else
        CollaborationMailer.notify(@collaboration).deliver_later
        redirect_to editor_stack_share_path(@stack),
          flash: { success: "#{@collaboration.user} has been added to the stack" }
      end
    else
      render :show
    end
  end

  def destroy
    @collaboration = @stack.collaborations.find_by(email: params[:email])
    @collaboration.destroy

    if @collaboration.invite?
      redirect_to editor_stack_share_path(@stack),
        alert: "Invite to #{@collaboration.invite_email} has been canceled"
    else
      redirect_to editor_stack_share_path(@stack),
        alert: "#{@collaboration.user} has been removed from the stack"
    end
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:email)
  end

  def find_stack
    decoded_id = MaskedId.decode(:stack, params[:stack_id])
    @stack = current_user.stacks.includes(:collaborators).find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @stack.owner?(current_user)
  end
end
