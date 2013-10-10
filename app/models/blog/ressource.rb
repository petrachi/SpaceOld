class Blog::Ressource < ActiveRecord::Base
  belongs_to :user
  
  scope :published, where(:published => true)  
  scope :pool, ->(pool){ where(:pool => pool) }
  
  
  validates_presence_of :user, :title, :summary, :link, :pool, :tag
  validates_uniqueness_of :title, :link
  validates_inclusion_of :pool, :in => [:technology_watch, :demo, :blog, :doc, :tutorial]
  
  
  def self.url
    URL.ressources_path
  end
  
  def pool_url
    URL.ressources_path :pool => pool
  end
end
