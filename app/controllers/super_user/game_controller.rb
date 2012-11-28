class SuperUser::GameController < SuperUser::ApplicationController
  include Game
  
  p User
  p Game
  p Game::Planet # if not here, Planet doesn't work - why ???
  p Planet
  
  def index
    @actions = [:create_planet]
  end
  
  # Action Links - Start
  
  # action form is actually realy specific to MainUser => finish it before use it !
  action_form :create_planet, :model => Planet,
              :validation => -> do
                "youpi"
              end
  # Actions Links - Stop
end
