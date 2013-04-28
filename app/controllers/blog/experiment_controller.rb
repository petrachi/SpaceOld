class Blog::ExperimentController < Blog::ApplicationController
  def get_location
    @section = :experiment
    super
  end
  
  def index
    @experiments = Blog::Experiment.published
  end
  
  def show
    @experiment = Blog::Experiment.published
      .where(:id => params[:id])
      .first
  end
  
  
  
  
  
  
  
  #### Dev zone
  if Rails.env == "development"
  
    def secret_1
    end
  
    def secret_2
    end
  
    def secret_tmp
    end
  
  end
  ####
end
