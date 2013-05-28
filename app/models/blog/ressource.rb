class Blog::Ressource < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  belongs_to :article
  
  scope :published, where(:published => true)
  default_scope published
  
  scope :primal, where(:primal => true)
  scope :pool, ->(pool){ where(:pool => pool) }
  
  validates_presence_of :user_id, :title, :summary, :link, :pool
  validates_uniqueness_of :title, :link
  validates_inclusion_of :pool, :in => [:technology_watch, :demo, :blog, :doc, :tutorial]
  
  def self.to_url
    URL.ressources_path
  end
  
  def pool_url
    URL.ressources_path :pool => pool
  end
end
