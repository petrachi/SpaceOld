class Game::HomeController < Game::ApplicationController
  layout "main"
  
  def index
  end
  
  def puts_planet
    @planet = Game::Planet.last
  end
  
  def puts_3d_planet
    @planet = Game::Planet.last
    
    render :layout => false
  end
end
