class Blog::Screencast < ActiveRecord::Base
  belongs_to :user
  
  include Blog::ScreencastDecorator
  include Blog::Poolable.new inclusion_in: [:try_hard]
  include Blog::Runnable
  include Blog::Seriable
  include Blog::Taggable
  
  scope :published, where(published:true)
  
  validates_presence_of :user, :title, :summary, :embed, :snippet
  validates_uniqueness_of :embed
end
