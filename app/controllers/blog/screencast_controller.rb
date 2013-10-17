class Blog::ScreencastController < Blog::ApplicationController
  def get_location
    @section = :screencast
    super
  end
  
  
  def index
    @screencasts = Blog::Screencast.published
    @screencasts = @screencasts.pool params[:pool] if params[:pool]
  end
  
  def show
    @screencast = Blog::Screencast.published
      .tagged(params[:tag])
  end
  
  
  
  #### Dev zone
  #if Rails.env == "development"
  
    def tmp
      
	  end
  
  
  
  #end
  ####
end
