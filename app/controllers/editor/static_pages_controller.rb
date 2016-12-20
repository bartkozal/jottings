class Editor::StaticPagesController < EditorController
  def show
    render params[:page]
  end
end
