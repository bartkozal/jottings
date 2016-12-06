class Editor::Stacks::RestoresController < EditorController
  before_action :find_stack, :require_ownership

  def create
    @stack.restore(recursive: true)
    redirect_to editor_trash_path, notice: %("#{@stack}" has been restored)
  end

  def destroy
    @stack.really_destroy!
    redirect_to editor_trash_path, alert: %("#{@stack}" has been permanently removed)
  end

  private

  def find_stack
    decoded_id = MaskedId.decode(:stack, params[:stack_id])
    @stack = current_user.owned_stacks.only_deleted.find(decoded_id)
  end

  def require_ownership
    raise ApplicationController::NotAuthorized unless @stack.owner?(current_user)
  end
end
