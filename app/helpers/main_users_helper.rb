module MainUsersHelper
  def current_main_user
    MainUsersController.new.current @_request
  end
end
