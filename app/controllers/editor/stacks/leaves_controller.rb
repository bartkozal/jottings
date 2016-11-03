class Editor::Stacks::LeavesController < EditorController
  before_action :find_stack

  def create
    @stack.collaborators.destroy(current_user)
    redirect_to root_path, notice: "You left the stack \"#{@stack}\""
  end

  private

  def find_stack
    decoded_id = MaskedId.decode(:stack, params[:stack_id])
    @stack = current_user.stacks.includes(:collaborators).find(decoded_id)
  end
end
