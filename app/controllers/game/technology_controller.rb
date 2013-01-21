class Game::TechnologyController < Game::ApplicationController
  def get_location
    @section = :technology
    super
  end
  
  def index
  end
end
