class Game::ApplicationController < ApplicationController
  include Game; layout "nav"
  include Game::ApplicationHelper
  
  before_filter :authorized?
  def authorized?
    redirect_to game_url(:subdomain => false), :alert => t(:restricted) unless User.current
  end
  
  def get_location
    @application, @sections = :game, [:profil]
  end
end
