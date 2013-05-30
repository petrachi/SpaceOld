class Blog::Article < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  has_one :experiment
  has_many :ressources
  
  scope :published, where(:published => true)
  default_scope published
  
  scope :primal, where(:primal => true)
  scope :pool, ->(pool){ where(:pool => pool) }
  
  validates_presence_of :user_id, :title, :summary, :code, :pool
  validates_uniqueness_of :title
  validates_inclusion_of :pool, :in => [:experiment, :ruby]
  
  def self.to_url
    URL.articles_path
  end
  
  def to_url
    URL.article_path self
  end
  
  def pool_url
    URL.articles_path :pool => pool
  end
end
