class Blog::ApplicationController < ApplicationController
  include Blog::ApplicationHelper

  def get_location
    @application, @sections = :blog, [:articles, :experiences, :ressources, :screencasts]
  end

  layout "nav"
end
