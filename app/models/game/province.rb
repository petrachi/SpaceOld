class Game::Province < ActiveRecord::Base
  attr_accessible :environment, :game_user_id
end
