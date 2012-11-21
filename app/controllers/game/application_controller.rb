class Game::ApplicationController < ApplicationController
  include Game; layout "game"
  include Game::ApplicationHelper
  
  before_filter :authorized?
  def authorized?
    redirect_to game_url(:subdomain => false), :alert => t(:restricted) unless User.current
  end
end
