class Game::Province < ActiveRecord::Base
  include AssociateNamespace; accessors_for_namespace :game
  
  belongs_to :planet, :foreign_key => :game_planet_id
  belongs_to :user
  
  #attr_accessible :game_planet_id, :environment, :game_user_id
  attr_protected
end
