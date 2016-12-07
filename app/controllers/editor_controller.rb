class EditorController < ApplicationController
  before_action :require_login, :set_new_document, :set_new_stack
  layout "editor"

  NEW_STACK_COLLABORATIONS = 2

  private

  def set_new_document
    @new_document = Document.new
  end

  def set_new_stack
    @new_stack = Stack.new

    NEW_STACK_COLLABORATIONS.times do
      @new_stack.collaborations.build
    end
  end
end
