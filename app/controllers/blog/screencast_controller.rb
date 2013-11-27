class Blog::ScreencastController < Blog::ApplicationController
  def get_location
    @section = :screencast
    super
  end
  
  
  def index
    @screencasts = Blog::Screencast.published.order("id desc")
    @screencasts = @screencasts.pool params[:pool] if params[:pool]
    @screencasts = @screencasts.serie params[:serie] if params[:serie]
    @screencasts = @screencasts.paginate params[:page].to_i, 16 if params[:page]
    @screencasts.map{ |screencast| screencast.decorate(view_context) }
  end
  
  def show
    @screencast = Blog::Screencast.published
      .tagged(params[:tag])
      .decorate(view_context)
  end
end
