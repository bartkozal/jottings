class ApplicationController < ActionController::Base
  class NotAuthorized < StandardError; end

  before_action :set_paper_trail_whodunnit

  include Clearance::Controller

  protect_from_forgery with: :exception

  rescue_from ApplicationController::NotAuthorized, with: :redirect_to_root

  protected

  def redirect_to_root
    redirect_to root_path
  end
end
