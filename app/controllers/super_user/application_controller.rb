class SuperUser::ApplicationController < ApplicationController
  include SuperUser; layout "super_user"
  include SuperUser::ApplicationHelper
  
  before_filter :authorized?
  def authorized?
    redirect_to root_url(:subdomain => false), :alert => t(:restricted) unless User.current
  end
  
  def get_location
    @application = :super_user
  end
end
