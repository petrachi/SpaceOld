class Blog::Article < ActiveRecord::Base
  attr_protected
  
  belongs_to :user, :foreign_key => :blog_user_id
  
  scope :published, where(:published => true)
  
  validates_presence_of :blog_user_id, :title, :summary, :content
  validates_uniqueness_of :title
end
