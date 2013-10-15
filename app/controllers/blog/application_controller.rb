class Blog::ApplicationController < ApplicationController
  include Blog::ApplicationHelper
  
  def get_location
    @application, @sections = :blog, [:article, :experiment, :screencast, :ressource]
  end
  
  layout "nav"
end
