class Blog::RessourceController < Blog::ApplicationController
  def get_location
    @section = :ressource
    super
  end
  
  def index
    @ressources = Blog::Ressource.published.public
  end
end
