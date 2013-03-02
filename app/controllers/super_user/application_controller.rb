class SuperUser::ApplicationController < ApplicationController
  include SuperUser::ApplicationHelper
  
  def get_location
    @application = :super_user
  end
end
