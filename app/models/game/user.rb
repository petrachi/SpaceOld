class Game::User < ActiveRecord::Base
  include UserInherit
  
  has_many :provinces
end
