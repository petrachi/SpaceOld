class Blog::ExperimentController < Blog::ApplicationController
  def get_location
    @section = :experiment
    super
  end
  
  def index
    @experiments = Blog::Experiment.with_primal_version
  end
  
  def show
    @experiment = Blog::Experiment.where(:id => params[:id])
      .with_version(params[:version_id])
      .first
  end
  
  
  
  
  
  
  
  #### Dev zone
  #if Rails.env == "development"
  
    def tmp
    end
  
  #end
  ####
end
