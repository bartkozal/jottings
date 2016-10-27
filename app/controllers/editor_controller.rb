class EditorController < ApplicationController
  before_action :require_login
  layout "editor"
end
