class Blog::RessourceController < Blog::ApplicationController
  def get_location
    @section = :ressource
    super
  end
  
  def index
    @ressources = Blog::Ressource.published
    @ressources = @ressources.pool params[:pool] if params[:pool]
  end
end
