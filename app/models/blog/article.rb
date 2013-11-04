class Blog::Article < ActiveRecord::Base
  belongs_to :user
  
  include Blog::ArticleDecorator
  include Blog::Runnable
  include Blog::Seriable
  include Blog::Taggable
  
  
  
  #include Blog::Poolable.new([:experience, :ruby, :css])
  
  
  
  scope :published, where(:published => true)  
  scope :pool, -> pool { where(:pool => pool) }
  
  validates_presence_of :user, :title, :summary, :pool
  validates_inclusion_of :pool, :in => [:experience, :ruby, :css]
  
  def pool_url
    URL.blog_articles_path :pool => pool
  end
end
