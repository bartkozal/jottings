class ApplicationController < ActionController::Base
  class NotAuthorized < StandardError; end

  before_action :set_paper_trail_whodunnit

  http_basic_authenticate_with(
    name: Rails.application.secrets.basic_auth_name,
    password: Rails.application.secrets.basic_auth_password
  ) if Rails.env.production?

  include Clearance::Controller

  protect_from_forgery with: :exception

  rescue_from ApplicationController::NotAuthorized, with: :redirect_to_root

  protected

  def redirect_to_root
    redirect_to root_path
  end
end
