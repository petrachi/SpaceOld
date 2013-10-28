class Blog::ApplicationController < ApplicationController
  include Blog::ApplicationHelper
  
  def get_location
    @application, @sections = :blog, [:article, :experience, :ressource, :screencast]
  end
  
  layout "nav"
end
