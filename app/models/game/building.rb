class Game::Building < ActiveRecord::Base
  include Game::AssociateJoin
  
  attr_accessible :base_employment, :base_production, :base_stock, :brief, :construction_time, :cost, :descr, :employment_modifier, :name, :product, :production_modifier, :stock_modifier
end
