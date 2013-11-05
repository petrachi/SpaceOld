class Blog::Article < ActiveRecord::Base
  belongs_to :user
  
  include Blog::ArticleDecorator
  include Blog::Poolable.new inclusion_in: [:experience, :ruby, :css]
  include Blog::Runnable
  include Blog::Seriable
  include Blog::Taggable
  
  scope :published, where(:published => true)  
  validates_presence_of :user, :title, :summary
end
