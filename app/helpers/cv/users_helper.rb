module Cv::UsersHelper
  def current_user
    Cv::UsersController.new.current @_request
  end
end
