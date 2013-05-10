class Blog::User < ActiveRecord::Base
  include UserInherit
  attr_protected
  
  has_many :articles
  has_many :experiments
  has_many :ressources
  has_many :versions
end
