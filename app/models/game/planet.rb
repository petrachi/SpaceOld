class Game::Planet < ActiveRecord::Base
  has_many :provinces
  
  attr_accessible :size
end
