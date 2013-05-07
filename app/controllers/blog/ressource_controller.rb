class Blog::RessourceController < Blog::ApplicationController
  def get_location
    @section = :ressource
    super
  end
  
  def index
    @ressources = Blog::Ressource.published
      .primal
      .group_by(&:pool)
  end
end
