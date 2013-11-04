class Blog::Experience < ActiveRecord::Base
  belongs_to :user
  
  include Blog::Runnable
  include Blog::Taggable
  
  scope :published, where(:published => true)
  scope :pool, -> pool { where(:pool => pool) }  
  
  validates_presence_of :user, :title, :summary, :pool
  validates_inclusion_of :pool, :in => [:experience]
  
  def pool_url
    URL.blog_experiences_path :pool => pool
  end
end
