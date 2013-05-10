class Blog::ArticleController < Blog::ApplicationController
  def get_location
    @section = :article
    super
  end
  
  def index
    @articles = Blog::Article.published
  end
  
  def show
    @article = Blog::Article.published
      .where(:id => params[:id])
      .includes(:experiment)
      .includes(:ressources)
      .first
  end
  
  
  
  
  #### Dev zone
  if Rails.env == "development"
  
    def secret_1
    end
  
    def secret_2
    end
  
  
  end
  ####
end
