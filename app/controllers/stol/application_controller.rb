class Stol::ApplicationController < ApplicationController
  include Stol::ApplicationHelper

  def get_location
    @application, @sections = :stol, []
  end

  layout "nav"
end
