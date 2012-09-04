class Cv::HomeController < Cv::ApplicationController
  before_filter :access_authorized?
  
  def index
  end
end
