class Blog::ArticleController < Blog::ApplicationController
  def get_location
    @section = :article
    super
  end
  
  def index
    @articles = Blog::Article.published
  end
  
  def show
    @article = Blog::Article.published.where(:id => params[:id]).first
  end
end
