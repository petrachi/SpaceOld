class Game::HomeController < Game::ApplicationController
  layout "main"
  
  def index
  end
  
  def puts_3d_planet    
    render :layout => false
  end
end
