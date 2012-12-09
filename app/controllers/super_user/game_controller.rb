class SuperUser::GameController < SuperUser::ApplicationController
  include Game
  
  p User
  
  p Game.reachable?
  p Planet.reachable?
  p Game::Planet.reachable?
  p Planet.reachable?
  p Game
  p Game::Planet # if not here, Planet doesn't work - why ???
  p Planet
  p Game::Province
  
  def index
    @actions = [:create_planet]
  end
  
  # Action Links - Start
  
  # action form is actually realy specific to MainUser => finish it before use it !
  action_form :create_planet, :model => Planet,
              :validation => -> do
                @planet.size.times{ Province.create :planet_id => @planet.id }
              end,
              :safe_validation => -> do
                @planet.provinces.size == @planet.size
              end
  # Actions Links - Stop
end
