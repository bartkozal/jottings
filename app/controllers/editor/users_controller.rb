class Editor::UsersController < EditorController
  before_action :skip_password_validation, only: :update

  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to editor_profile_path, flash: { success: "Settings updated" }
    else
      render :show
    end
  end

  def destroy
    current_user.collaborations.delete_all
    current_user.delete
    redirect_to root_path, alert: "Your account has been removed"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

  def skip_password_validation
    params[:user].reject! { |name, value| name == "password" if value.blank? }
  end
end
