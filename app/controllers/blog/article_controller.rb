class Blog::ArticleController < Blog::ApplicationController
  def get_location
    @section = :article
    super
  end
  
  
  def index
    @articles = Blog::Article.published.order("id desc")
    @articles = @articles.pool params[:pool] if params[:pool]
  end
  
  def show
    @article = Blog::Article.published
      .tagged(params[:tag])
  end
  
  
  
  #### Dev zone
  #if Rails.env == "development"
  
    def tmp
      
	  end
  
  
  
  #end
  ####
end
