class ApplicationController < ActionController::Base
  class NotAuthorised < StandardError; end

  include Clearance::Controller

  protect_from_forgery with: :exception
end
