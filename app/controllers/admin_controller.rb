class AdminController < ApplicationController
  before_action :require_login, :require_admin

  ADMINS = %w(bkzl@me.com mackozal@me.com)

  private

  def require_admin
    raise ApplicationController::NotAuthorized unless ADMINS.any? { |email| current_user.email == email }
  end
end
