class Blog::Ressource < ActiveRecord::Base
  belongs_to :user
  
  scope :published, where(:published => true)  
  scope :pool, -> pool { where(:pool => pool) }
  
  
  validates_presence_of :user, :title, :summary, :link, :pool, :tag
  validates_uniqueness_of :link, :tag
  validates_inclusion_of :pool, :in => [:technology_watch, :demo, :blog, :doc, :tutorial]
  
  
  def to_param() tag end
  
  def pool_url
    URL.blog_ressources_path :pool => pool
  end
end
