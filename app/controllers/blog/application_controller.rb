class Blog::ApplicationController < ApplicationController
  include Blog::ApplicationHelper
  
  def get_location
    @application, @sections = :blog, []
  end
  
  layout "nav"
end
