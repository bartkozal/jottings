class PasswordsController < Clearance::PasswordsController

  private

  def find_user_by_id_and_confirmation_token
    user_param = Clearance.configuration.user_id_parameter
    token = session[:password_reset_token] || params[:token]

    Clearance.configuration.user_model.
      find_by_id_and_confirmation_token MaskedId.decode(params[user_param]), token.to_s
  end
end
