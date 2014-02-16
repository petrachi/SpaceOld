class Blog::ScreencastController < Blog::ApplicationController
  def get_location
    @section = :screencast
    super
  end
  
  
  def index
    @screencasts = Blog::Screencast.published.order("id desc")
    @screencasts = @screencasts.pool params[:pool] if params[:pool]
    @screencasts = if params[:serie]
      @screencasts.serie params[:serie] 
    else
      @screencasts.firsts_of_series
    end
    
    @screencasts = @screencasts.paginate params[:page].to_i, 16 if params[:page] || (params[:page] = 1)
    
    @screencasts.map! do |screencast| 
      screencast.decorate view_context, showcase: params[:serie].blank?
    end
  end
  
  def show
    @screencast = Blog::Screencast.published
      .tagged(params[:tag])
      .decorate(view_context)
  end
end
