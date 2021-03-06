module EditorHelper
  def open_new_stack_modal?
    current_page?(root_path) && !cookies.signed[:last_visited_document]
  end

  def active_document?(document)
    params[:id] == document.to_param
  end
end
