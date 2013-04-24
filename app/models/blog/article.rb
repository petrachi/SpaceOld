class Blog::Article < ActiveRecord::Base
  attr_protected
  
  belongs_to :user, :foreign_key => :blog_user_id
  has_many :experiments, :foreign_key => :blog_article_id
  has_many :ressources, :as => :source
  
  scope :published, where(:published => true)
  
  validates_presence_of :blog_user_id, :title, :summary, :content
  validates_uniqueness_of :title
  validates_length_of :content, :maximum => 64.kilobytes - 1
end
