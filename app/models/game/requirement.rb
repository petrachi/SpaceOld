class Game::Requirement < ActiveRecord::Base
  # toto polymorphic + acticeadmin
  belongs_to :struct, :polymorphic => true
  
  attr_accessible :lvl, :struct_id, :struct_type
end
