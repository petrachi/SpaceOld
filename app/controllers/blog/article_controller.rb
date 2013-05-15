class Blog::ArticleController < Blog::ApplicationController
  def get_location
    @section = :article
    super
  end
  
  def index
    @articles = Blog::Article.all
  end
  
  def show
    @article = Blog::Article.where(:id => params[:id])
      .includes(:experiment)
      .includes(:ressources)
      .first
  end
  
  
  
  
  #### Dev zone
  if Rails.env == "development"
  
    def tmp
    end
  
  
  
  end
  ####
end
