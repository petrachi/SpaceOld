class Blog::Experience < ActiveRecord::Base
  belongs_to :user
  
  has_one :snippet, as: :runnable, conditions: "published = true"
  delegate :run, to: :snippet
  
  scope :published, where(:published => true)
  scope :pool, -> pool { where(:pool => pool) }  
  
  
  validates_presence_of :user_id, :title, :summary, :snippet, :pool, :tag
  validates_uniqueness_of :tag
  validates_inclusion_of :pool, :in => [:experience]
  
  
  def to_param() tag end
  def self.tagged(tag) where(tag: tag).first end
  
  def pool_url
    URL.blog_experiences_path :pool => pool
  end
end
