class Blog::Experience < ActiveRecord::Base
  belongs_to :user
  
  include Blog::Poolable.new inclusion_in: [:experience]
  include Blog::Runnable
  include Blog::Taggable
  
  scope :pool, -> pool { where(:pool => pool) }  
  
  validates_presence_of :user, :title, :summary
end
