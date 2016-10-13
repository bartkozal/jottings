class StaticPagesController < ApplicationController
  layout "static_page"

  def show
    render params[:page]
  end
end
