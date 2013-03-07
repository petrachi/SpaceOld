class SuperUser::ApplicationController < ApplicationController
  include SuperUser::ApplicationHelper
  
  def get_location
    @application, @sections = :super_user, [:blog]    
  end
end
