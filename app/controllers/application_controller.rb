class ApplicationController < ActionController::Base
  class NotAuthorized < StandardError; end

  include Clearance::Controller

  protect_from_forgery with: :exception

  rescue_from ApplicationController::NotAuthorized, with: :redirect_to_root

  protected

  def redirect_to_root
    redirect_to root_path
  end
end
