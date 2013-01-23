class Gems::ProfileController < Gems::ApplicationController
  def get_location
    @section = :profile
    super
  end
  
  def index
    

     p Gem 
     p Gem.class, Gems::Gem, Gems::Gem.class, User 
 #   p Gem.find(:css_grid).downloads
    @gem = Gem.find(:css_grid)
    
  end
end
