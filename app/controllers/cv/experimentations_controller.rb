class Cv::ExperimentationsController < Cv::ApplicationController
  before_filter :access_authorized?, :except => :show
  
  def index
  end

  def show
  end

  def edit
  end
end
