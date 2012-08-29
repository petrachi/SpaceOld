class Game::Requirement < ActiveRecord::Base
  # toto polymorphic + acticeadmin
  
  attr_accessible :lvl, :object_id, :object_type
end
