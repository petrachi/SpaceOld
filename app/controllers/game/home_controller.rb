class Game::HomeController < Game::ApplicationController
  layout "main"
  
  def index
  end
  
  def puts_planet
    @planet = Game::Planet.last
  end
end
