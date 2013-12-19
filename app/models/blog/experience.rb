class Blog::Experience < ActiveRecord::Base
  belongs_to :user
  
  act_as_paginable
  
  include Blog::Poolable.new inclusion_in: [:experience]
  include Blog::Publishable
  include Blog::Runnable
  include Blog::Taggable
  
  validates_presence_of :user, :title, :summary
end
