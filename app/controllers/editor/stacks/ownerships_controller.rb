class Editor::Stacks::OwnershipsController < EditorController
  before_action :find_stack
  before_action :require_ownership

  def update
    @user = @stack.collaborators.find_by(email: email)
    @stack.owner = @user
    @stack.save
    redirect_to root_path,
      notice: %(#{@user} is a new owner of "#{@stack}")
  end

  private

  def find_stack
    decoded_id = MaskedId.decode(:stack, params[:stack_id])
    @stack = current_user.stacks.find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @stack.owner?(current_user)
  end

  def email
    params.require(:email)
  end
end
