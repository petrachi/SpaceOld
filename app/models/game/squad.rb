class Game::Squad < ActiveRecord::Base
  include Game::AssociateJoin
  
  attr_accessible :base_atq, :base_def, :base_employment, :base_move, :base_precision, :base_range, :brief, :cost, :descr, :name, :recuitment_time
end
