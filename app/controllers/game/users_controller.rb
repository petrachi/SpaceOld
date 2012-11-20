class Game::UsersController < Game::ApplicationController
  before_filter :install_authorize, :only => :install
  def install_authorize
    if MainUser.current and User.current.blank?
    else
      redirect_to :subdomain=>false, :controller=>:home, :action=>:game #Turbolinks.visit(path)
    end
  end
  
  def install
    User.create :main_user => MainUser.current
    redirect_to game_path(:subdomain => false)
  end
end