class Game::ProfilController < Game::ApplicationController
  def get_location
    @section = :profil
    super
  end
  
  def index
  end
end
