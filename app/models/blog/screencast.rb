class Blog::Screencast < ActiveRecord::Base
  belongs_to :user
  
  has_one :snippet, as: :runnable, conditions: "published = 1"
  delegate :run, to: :snippet
  
  scope :published, where(:published => true)  
  scope :pool, -> pool { where(:pool => pool) }
  
  
  validates_presence_of :user, :title, :summary, :embed, :snippet, :pool, :tag
  validates_uniqueness_of :embed, :tag
  validates_inclusion_of :pool, :in => [:try_hard]
  
  
  def to_param() tag end
  def self.tagged(tag) where(tag: tag).first end
  
  def pool_url
    URL.blog_screencasts_path :pool => pool
  end
end
