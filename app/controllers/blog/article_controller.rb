class Blog::ArticleController < Blog::ApplicationController
  def get_location
    @section = :article
    super
  end
  
  def index
    if params[:pool]
      @articles = Blog::Article.pool params[:pool]
    else
      @articles = Blog::Article.all
    end
  end
  
  def show
    @article = Blog::Article.where(:id => params[:id])
      .includes(:experiment)
      .includes(:ressources)
      .first
  end
  
  def pool
    @articles = Blog::Article.pool params[:pool]
  end
  
  
  #### Dev zone
  #if Rails.env == "development"
  
    def tmp
    end
  
  
  
  #end
  ####
end
