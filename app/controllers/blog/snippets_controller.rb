class Blog::SnippetsController < Blog::ApplicationController
  layout false

  def show
    @snippet = Blog::Snippet
      .where(id: params[:id])
      .first
  end
end
