class Blog::Experiment < ActiveRecord::Base
  attr_protected
  
  belongs_to :user
  
  scope :published, where(:published => true)
end
