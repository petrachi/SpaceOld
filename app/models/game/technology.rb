class Game::Technology < ActiveRecord::Base
  include Game::AssociateJoin
  
  attr_accessible :brief, :cost, :descr, :domain, :domain_modifier, :name, :research_time
end
