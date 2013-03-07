class Blog::User < ActiveRecord::Base
  include UserInherit
  attr_protected
  
  has_many :experiments
end
