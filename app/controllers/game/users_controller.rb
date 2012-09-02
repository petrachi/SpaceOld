class Game::UsersController < Game::ApplicationController
  def install
    User.create :main_user => MainUsersController.new.current(@_request)
    redirect_to root_url, :notice => "Globalized"
  end
  
  def current request = @_request
    MainUsersController.new.current(request).try(:game_user)    
  end
end