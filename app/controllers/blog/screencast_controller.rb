class Blog::ScreencastController < Blog::ApplicationController
  def get_location
    @section = :screencast
    super
  end
  
  
  def index
    @screencasts = Blog::Screencast.published.order("id desc")
    @screencasts = @screencasts.pool params[:pool] if params[:pool]
    @screencasts.map{ |screencast| screencast.decorate(view_context) }
  end
  
  def show
    @screencast = Blog::Screencast.published
      .tagged(params[:tag])
      .decorate(view_context)
  end
  
  
  
  #### Dev zone
  #if Rails.env == "development"
  
    def tmp
      
	  end
  
  
  
  #end
  ####
end
