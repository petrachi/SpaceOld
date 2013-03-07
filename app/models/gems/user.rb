class Gems::User < ActiveRecord::Base
  include UserInherit
  attr_protected
end
