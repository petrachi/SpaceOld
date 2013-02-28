class Gems::CssGridController < Gems::ApplicationController
  def get_location
    @section = :css_grid
    @gem = Gems::Gem.find(:css_grid)
    super
  end
  
  def index    
  end
end
