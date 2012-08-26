class Game::User < ActiveRecord::Base
  include TableInherit; inherit MainUser
  
  attr_accessible :user_id
end
