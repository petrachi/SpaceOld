class Game::Planet < ActiveRecord::Base
  attr_accessible :game_province_id, :size
end
