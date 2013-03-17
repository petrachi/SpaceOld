class Blog::Article < ActiveRecord::Base
  attr_protected
  
  belongs_to :user, :foreign_key => :blog_user_id
  
  scope :published, where(:published => true)
  
  validates_presence_of :blog_user_id, :title, :summary, :content
  validates_uniqueness_of :title
  validates_length_of :content, :maximum => 64.kilobytes - 1
  
  #before_save :strip_whithspaces!
  def strip_whithspaces!
    p content.size
    content.gsub! /^\s*(.*)\s*$/, '\1'
    
    
    self[:content] = " " * 7787
  p content.size
  
  end
end
