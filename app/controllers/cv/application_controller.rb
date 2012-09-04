class Cv::ApplicationController < ApplicationController
  include Cv
  include Cv::ApplicationHelper
  
  def access_authorized?
    if MainUsersController.new.current(@_request).present? and current_user.present?
    else
      flash[:alert] = "acces non authorise"
      redirect_to :subdomain=>false, :controller=>:home, :action=>:cv
    end
  end
end
