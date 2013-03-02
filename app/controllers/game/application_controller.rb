class Game::ApplicationController < ApplicationController
  include Game::ApplicationHelper
  
  def get_location
    @application, @sections = :game, [:building, :technology, :squad, :profile]
  end
  
  layout "nav"
end
