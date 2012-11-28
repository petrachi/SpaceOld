class SuperUser::GameController < SuperUser::ApplicationController
  def index
    @actions = [:create_planet]
  end
  
  # Action Links - Start
  action_form :create_planet
  # Actions Links - Stop
end
