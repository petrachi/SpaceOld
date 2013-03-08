class SuperUser::BlogController < SuperUser::ApplicationController
  def get_location
    @section = :blog
    super
  end
  
  def index
    @action_links = [:experiment]
    @tables = [:experiment]
  end
  
  # Action Links
  action_form :experiment, 
    :model => Blog::Experiment, 
    :default_params => ->(params) do
      {:user => Blog::User.current}
    end
  # Action links - End
  
  # Tables
  def experiments
  end
  # Tables - End
end
