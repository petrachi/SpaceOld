class Blog::Ressource < ActiveRecord::Base
  belongs_to :user
  
  acts_as_decorables
  
  include Blog::Poolable.new inclusion_in: [:article, :video, :lib, :misc]
  include Blog::Publishable
  include Blog::Taggable
  
  validates_presence_of :user, :title, :summary, :link
  validates_uniqueness_of :link
end
