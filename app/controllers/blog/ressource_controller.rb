class Blog::RessourceController < Blog::ApplicationController
  def get_location
    @section = :ressource
    super
  end
  
  def index
    @ressources = Blog::Ressource.published
    @ressources = @ressources.pool params[:pool] if params[:pool]
    
    @ressources = @ressources.map do |ressource|
        ressource.decorate view_context
      end
      .group_by(&:pool)
  end
  
  def pool
    @ressources = Blog::Ressource.published
    @ressources = @ressources.pool params[:pool] if params[:pool]
    @ressources = @ressources.map do |ressource|
        ressource.decorate view_context
      end
  end
  
  def show
    @ressource = Blog::Ressource.published
      .tagged(params[:tag])
      .decorate(view_context)
  end
end
