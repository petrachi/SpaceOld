class Game::SquadController < Game::ApplicationController
  def get_location
    @section = :squad
    super
  end
  
  def index
  end
end
