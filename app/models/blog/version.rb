class Blog::Version < ActiveRecord::Base
  attr_protected
  
  belongs_to :experiment, :foreign_key => :blog_experiment_id
  
  scope :published, where(:published => true)
  
  validates_presence_of :blog_experiment_id, :title, :code
  validates_uniqueness_of :title, :scope => :blog_experiment_id
end
