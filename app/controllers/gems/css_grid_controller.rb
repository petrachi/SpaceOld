class Gems::CssGridController < Gems::ApplicationController
  def get_location
    @section = :css_grid
    super
  end

  before_filter :get_gem
  def get_gem
    @gem = Gems::Gem.find(:css_grid)
  end

  def index    
  end
end
