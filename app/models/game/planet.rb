class Game::Planet < ActiveRecord::Base
  include AssociateNamespace; accessors_for_namespace :game
  
  #has_many :provinces
  
  has_many :provinces, :foreign_key => :game_planet_id #, :class_name => Game::Province.name
  
  attr_protected
end
