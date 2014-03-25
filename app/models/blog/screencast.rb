class Blog::Screencast < ActiveRecord::Base
  belongs_to :user
  
  acts_as_decorables
  act_as_paginable
  
  include Blog::Poolable.new inclusion_in: [:try_hard, :htcpcp, :wcs_jane]
  include Blog::Publishable
  include Runnable
  include Blog::Seriable
  include Blog::Taggable
  
  validates_presence_of :user, :title, :summary, :embed, :snippet
  validates_uniqueness_of :embed
end
