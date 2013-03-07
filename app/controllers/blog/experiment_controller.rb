class Blog::ExperimentController < Blog::ApplicationController
  def get_location
    @section = :experiment
    super
  end
  
  def index
    @experiments = Blog::Experiment.published
  end
  
  def show
    @experiment = Blog::Experiment.published.where(:id => params[:id]).first
  end
end
