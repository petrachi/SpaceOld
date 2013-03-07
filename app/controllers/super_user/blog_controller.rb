class SuperUser::BlogController < SuperUser::ApplicationController
  def get_location
    @section = :experiment
    super
  end
  
  def index
    @action_links = [:experiment]
    @tables = [:experiment]
  end
end
