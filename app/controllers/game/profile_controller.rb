class Game::ProfileController < Game::ApplicationController
  def get_location
    @section = :profile
    super
  end
  
  def index
  end
end
