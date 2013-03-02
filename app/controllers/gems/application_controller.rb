class Gems::ApplicationController < ApplicationController
  include Gems::ApplicationHelper
  
  def get_location
    @application, @sections = :gems, [:css_grid]
  end
  
  layout "nav"
end
