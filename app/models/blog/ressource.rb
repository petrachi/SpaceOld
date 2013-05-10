class Blog::Ressource < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  belongs_to :article
  
  scope :published, where(:published => true)
  scope :primal, where(:primal => true)
  
  validates_presence_of :user_id, :title, :summary, :link, :pool
  validates_uniqueness_of :title, :link
  validates_inclusion_of :pool, :in => [:technology_watch, :demo, :blog, :doc, :tutorial]
  
  def self.to_url
    URL.ressources_path
  end
end
