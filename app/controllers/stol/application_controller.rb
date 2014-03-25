class Stol::ApplicationController < ApplicationController
  include Stol::ApplicationHelper

  def get_location
    @application, @sections = :stol, [:rubies]
  end

  layout "nav"
end
