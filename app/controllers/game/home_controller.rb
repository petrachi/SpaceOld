class Game::HomeController < Game::ApplicationController
  layout "game/main"
  
  def index
    @sections = [:profil]
  end
end
