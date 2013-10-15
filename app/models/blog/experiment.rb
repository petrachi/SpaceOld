class Blog::Experiment < ActiveRecord::Base
  belongs_to :user
  
  has_one :snippet, as: :runnable
  delegate :run, to: :snippet
  
  scope :published, where(:published => true)
  scope :pool, -> pool { where(:pool => pool) }  
  
  
  validates_presence_of :user_id, :title, :summary, :snippet, :pool, :tag
  validates_uniqueness_of :tag
  validates_inclusion_of :pool, :in => [:experiment]
  
  
  def pool_url
    URL.blog_experiments_path :pool => pool
  end
end
