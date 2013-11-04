class Blog::ArticleController < Blog::ApplicationController
  def get_location
    @section = :article
    super
  end
  
  
  def index
    @articles = Blog::Article.published.order("id desc")
    @articles = @articles.pool params[:pool] if params[:pool]
    @articles.map{ |article| article.decorate(view_context) }
  end
  
  def show
    @article = Blog::Article.published
      .tagged(params[:tag])
      .decorate(view_context)
  end
  
  
  
  #### Dev zone
  #if Rails.env == "development"
  
    def tmp
      @article = Blog::Article.first.decorate(view_context)
	  end
  
  
  
  #end
  ####
end
