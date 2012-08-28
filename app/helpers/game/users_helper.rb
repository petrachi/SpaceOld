module Game::UsersHelper
  def current_user
    Game::UsersController.new.current @_request
  end
end
