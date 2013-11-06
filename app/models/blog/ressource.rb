class Blog::Ressource < ActiveRecord::Base
  belongs_to :user
  
  include Blog::Poolable.new inclusion_in: [:technology_watch, :demo, :blog, :doc, :tutorial]
  include Blog::Publishable
  include Blog::Taggable
  
  validates_presence_of :user, :title, :summary, :link
  validates_uniqueness_of :link
end
