class Blog::Article < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  has_many :experiments
  has_many :ressources
  
  scope :published, where(:published => true)
  
  validates_presence_of :user_id, :title, :summary, :code
  validates_uniqueness_of :title
  
  def self.to_url
    URL.articles_path
  end
  
  def to_url
    URL.article_path self
  end
end

