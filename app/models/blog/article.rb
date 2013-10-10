class Blog::Article < ActiveRecord::Base
  belongs_to :user
  
  has_one :snippet, as: :runnable
  delegate :run, to: :snippet
  
  scope :published, where(:published => true)  
  scope :pool, -> pool { where(:pool => pool) }
  
  
  validates_presence_of :user, :title, :summary, :snippet, :pool, :tag
  validates_uniqueness_of :tag
  validates_inclusion_of :pool, :in => [:experiment, :ruby, :css]
  
  
  def self.url
    URL.articles_path
  end
  
  def url
    URL.article_path self
  end
  
  def pool_url
    URL.articles_path :pool => pool
  end
end
