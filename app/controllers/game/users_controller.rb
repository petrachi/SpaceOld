class Game::UsersController < Game::ApplicationController
  before_filter :install_authorized?, :only => :install
  def install_authorized?
    redirect_to game_url(:subdomain => false) unless MainUser.current and User.current.blank?
  end
  
  def install
    User.create :main_user => MainUser.current
    redirect_to game_url(:subdomain => false)
  end
end