module MainUsersHelper
  def current_user
    MainUsersController.new.current @_request
  end
end
