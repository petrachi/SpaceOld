class Blog::Ressource < ActiveRecord::Base
  attr_protected
  
  belongs_to :user, :foreign_key => :blog_user_id
  belongs_to :source, :polymorphic => true
  
  scope :published, where(:published => true)
  scope :public, where(:public => true)
  
  validates_presence_of :blog_user_id, :title, :summary, :link, :pool
  validates_uniqueness_of :title, :link
  validates_inclusion_of :pool, :in => [:technology_watch, :demo, :blog]
end
