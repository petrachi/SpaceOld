class Game::TechnologyJoin < ActiveRecord::Base
  attr_accessible :game_province_id, :game_technology_id, :game_user_id, :lvl
end
