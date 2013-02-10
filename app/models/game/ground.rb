class Game::Ground < ActiveRecord::Base
  include AssociateNamespace; accessors_for_namespace :game
  
  has_many :provinces
  attr_protected
end
