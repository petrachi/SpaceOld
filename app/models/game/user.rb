class Game::User < ActiveRecord::Base
  include UserInherit
  
  has_many :provinces
  
  def to_s
    email
  end
end
