class Blog::RessourceController < Blog::ApplicationController
  def get_location
    @section = :ressource
    super
  end
  
  def index
    if params[:pool]
      @ressources = Blog::Ressource.pool params[:pool]
    else
      @ressources = Blog::Ressource.primal
    end
  end
end
