class Blog::ArticleController < Blog::ApplicationController
  def get_location
    @section = :article
    super
  end
  
  
  def index
    @articles = Blog::Article.published.order("id desc")
    @articles = @articles.pool params[:pool] if params[:pool]
    @articles = @articles.serie params[:serie] if params[:serie]
    
    @articles = @articles.paginate params[:page].to_i, 16 if params[:page] || (params[:page] = 1)
    
    @articles.map!{ |article| article.decorate(view_context) }
  end
  
  def show
    @article = Blog::Article.published
      .tagged(params[:tag])
      .decorate(view_context)
  end
  
  
  
  #### Dev zone
  #if Rails.env == "development"
  def tmp
    params[:page] ||= "1"
    render :template => "blog/article/tmp_#{ params[:page] }"
	  end
  
  
  
  #end
  ####
end
