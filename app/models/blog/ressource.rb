class Blog::Ressource < ActiveRecord::Base
  belongs_to :user
  
  include Blog::Taggable
  
  scope :published, where(:published => true)  
  scope :pool, -> pool { where(:pool => pool) }
  
  validates_presence_of :user, :title, :summary, :link, :pool
  validates_uniqueness_of :link
  validates_inclusion_of :pool, :in => [:technology_watch, :demo, :blog, :doc, :tutorial]
    
  def pool_url
    URL.blog_ressources_path :pool => pool
  end
end
