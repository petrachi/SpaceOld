class Gems::HomeController < Gems::ApplicationController
  layout "main"
  
  def index
  end
  
  def ten_thousand
    @gem = Gems::Gem.find(:css_grid)
  end
end
