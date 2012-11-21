class Game::ApplicationController < ApplicationController
  include Game; layout "game/nav"
  include Game::ApplicationHelper
  
  before_filter :authorized?
  def authorized?
    redirect_to game_url(:subdomain => false), :alert => t(:restricted) unless User.current
  end
  
  # put in before filter or find a way to access in view
  #SECTIONS = [:profil]
end
