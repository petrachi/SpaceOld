module Private::UsersHelper
  def current_user
    Private::UsersController.new.current @_request
  end
end
