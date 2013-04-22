class Blog::User < ActiveRecord::Base
  include UserInherit
  attr_protected
  
  has_many :articles, :foreign_key => :blog_user_id
  has_many :experiments, :foreign_key => :blog_user_id
  has_many :ressources, :foreign_key => :blog_user_id
end
