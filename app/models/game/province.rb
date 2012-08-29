class Game::Province < ActiveRecord::Base
  belongs_to :planet
  belongs_to :user
  
  attr_accessible :game_planet_id, :environment, :game_user_id
end
