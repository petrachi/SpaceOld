class Game::BuildingJoin < ActiveRecord::Base  
  attr_accessible :current_employment, :current_production, :current_stock, :game_building_id, :game_province_id, :game_user_id, :lvl
end
