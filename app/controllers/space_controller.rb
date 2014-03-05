class SpaceController < ApplicationController

  def index
    @applications = [:blog, :stol]
  end
end
