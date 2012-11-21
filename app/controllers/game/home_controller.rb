class Game::HomeController < Game::ApplicationController
  def index
    @sections = [:profil]
  end
end
