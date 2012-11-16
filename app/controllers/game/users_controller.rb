class Game::UsersController < Game::ApplicationController
  before_filter :install_authorize, :only => :install
  def install_authorize
    if MainUsersController.new.current(@_request).present? and current.blank?
    else
      redirect_to :subdomain=>false, :controller=>:home, :action=>:cv
    end
  end
  
  def install
    User.create :main_user => MainUsersController.new.current(@_request)
    redirect_to :subdomain=>false, :controller=>:home, :action=>:cv
  end
  
  def installed? request = @_request
    current(request).present?
  end
  
  def current request = @_request
    MainUsersController.new.current(request).try(:cv_user)    
  end
end