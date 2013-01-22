class Gems::ApplicationController < ApplicationController
  include Gems; layout "nav"
  include Gems::ApplicationHelper
  
  before_filter :authorized?
  def authorized?
    redirect_to root_url(:subdomain => false), :alert => t(:restricted) unless User.current
  end
  
  def get_location
    @application, @sections = :gems, [:profile]
  end
end
