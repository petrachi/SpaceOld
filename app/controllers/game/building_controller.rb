class Game::BuildingController < Game::ApplicationController
  def get_location
    @section = :building
    super
  end
  
  def index
  end
end
